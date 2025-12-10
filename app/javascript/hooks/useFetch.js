import { useState, useEffect, useRef, useCallback } from "react";

export default function useFetch(url, { method = "GET", body = null, headers = {}, auto = true, deps = [] } = {}) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const controllerRef = useRef(null);

  const fetcher = useCallback(
    async (opts = {}) => {
      controllerRef.current?.abort();
      const controller = new AbortController();
      controllerRef.current = controller;
      setLoading(true);
      setError(null);
      try {
        const res = await fetch(url, {
          method: opts.method || method,
          headers: { "Content-Type": "application/json", ...(opts.headers || headers) },
          body: opts.body != null ? (typeof opts.body === "string" ? opts.body : JSON.stringify(opts.body)) : body,
          signal: controller.signal,
          credentials: "same-origin",
        });
        const text = await res.text();
        let payload = null;
        try {
          payload = text ? JSON.parse(text) : null;
        } catch (e) {
          payload = text;
        }
        if (!res.ok) throw new Error(payload?.error || res.statusText || "Request failed");
        setData(payload);
        return payload;
      } catch (err) {
        if (err.name === "AbortError") return;
        setError(err);
        throw err;
      } finally {
        setLoading(false);
      }
    },
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [url, method, JSON.stringify(body), JSON.stringify(headers)]
  );

  useEffect(() => {
    if (auto) fetcher();
    return () => controllerRef.current?.abort();
    // deps allow callers to re-trigger effect externally
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, deps);

  const reload = useCallback((opts = {}) => fetcher(opts), [fetcher]);

  return { data, loading, error, reload };
}
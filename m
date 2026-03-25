Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7C33B6F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464002; cv=none; b=jtQZVa5vZN727aTmD55B+S9bMxJwrftMUBIyxTC1GLh19fQkkjkISrQKzKFaKCfM6F885d99IMIPO+UFQsJaolWh0GwlS/aZLb2NZpjJ94Jf8xZFmXuisXjZYaAJBJ4Bwf1TZUAneNzVRzHxGYsW6AfxMyBiNIq2xgtZ9Nrzoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464002; c=relaxed/simple;
	bh=IbUCOPop+VeAxf7Go8Qb9skjaDYOA09om7m98Up1aEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=If626vVdzaPmkqR+BPpSs0XPqnbkXt8CzbVfU3FMnJTfXLtKKCCAkgdjt7uIykcT9qYryKqrc9VSAP+zQdL7z1Uz8LGwsM11QMxNUTNMUru+sr9ASwgSX5x4CpudSUcNT6oszzHkWYSmP1RtTVF5JAK87s5V6i3rrn3qDp2JtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTVuqrl8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTVuqrl8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774463996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jJ24xyMLz5nvybLbU2CjERbvdu2Z++lvJfI0T3inaw=;
	b=jTVuqrl8u5gtpdCdTuH64HvfdQz182lfW9HNW8NUwnRTxfCkGRzNL/eXFoInhnQ/Zm9jpC
	khmG0NEWuok55XaeH1my2qfBiz3TuV6n0uBbbl8OvoD9zLJZDHbLpPcvNQmXH98isaUo1n
	EPFmQsL65GRp2d3ml9ugTHxWhA7oGPI=
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v5 1/2] sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
Date: Thu, 26 Mar 2026 02:39:15 +0800
Message-Id: <3c559c50d15c55f1f2f81f77b4f8c65c05858de3.1774463505.git.wen.yang@linux.dev>
In-Reply-To: <cover.1774463505.git.wen.yang@linux.dev>
References: <cover.1774463505.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Historically, changes to how struct ctl_table entries are initialized
(e.g. removing the child field, const-qualifying ctl_table) required
touching hundreds of files across all subsystems.  Such series require
the attention of many maintainers, sometimes need to be pulled into
mainline in a special way, and create lots of unnecessary churn.  This
will all go away with the CTLTBL_ENTRY_XXX helper macros.

Add a family of CTLTBL_ENTRY_XXX() macros that reduce the boilerplate
of initialising struct ctl_table.  The suffix letters encode the
accepted arguments: V derives .procname from the variable name, N takes
an explicit name, M an explicit mode, H an explicit handler, R enables
range checking via extra1/extra2, and L overrides .maxlen.  Unspecified
fields default to: .procname = #var, .data = &var, .maxlen = sizeof(var),
and .proc_handler selected by _Generic() from the variable type.

Auto-dispatch maps int/unsigned int to proc_dointvec/proc_douintvec,
long/unsigned long to proc_doulongvec_minmax, bool to proc_dobool, and
u8 to proc_dou8vec_minmax.  Range variants (R suffix) substitute the
corresponding _minmax handler.  char[] cannot be dispatched via
_Generic(); use CTLTBL_ENTRY_VNMH() with proc_dostring explicitly.
Pass SYSCTL_NULL as the variable argument for entries where .data must
be NULL.

No functional change.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        |   2 +
 2 files changed, 309 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2886fbceb5d6..f5aa7bc319da 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -175,6 +175,313 @@ struct ctl_table {
 	void *extra2;
 } __randomize_layout;
 
+/**
+ * struct _sysctl_null_type - sentinel type for variable-less entries
+ */
+struct _sysctl_null_type { char __dummy; };
+
+/**
+ * _sysctl_null_marker - sentinel instance used by SYSCTL_NULL
+ *
+ * Passed via SYSCTL_NULL to mark entries with no associated variable.
+ * Detected by _Generic() dispatch in CTLTBL_ENTRY_XXX().
+ */
+extern const struct _sysctl_null_type _sysctl_null_marker;
+
+/**
+ * SYSCTL_NULL - pass as __var for entries with no associated variable
+ */
+#define SYSCTL_NULL (_sysctl_null_marker)
+
+/**
+ * __CTL_AUTO_HANDLER - select proc_handler based on the variable type
+ *
+ * Supported types: int, unsigned int, long, unsigned long, bool, u8.
+ * char arrays (strings) are not supported; use CTLTBL_ENTRY_VNMH() with
+ * proc_dostring instead.
+ *
+ * @__var: kernel variable (value, not address), or SYSCTL_NULL
+ */
+#define __CTL_AUTO_HANDLER(__var)					\
+	_Generic((__var),						\
+			int          : proc_dointvec,			\
+			unsigned int : proc_douintvec,			\
+			long         : proc_doulongvec_minmax,		\
+			unsigned long: proc_doulongvec_minmax,		\
+			bool         : proc_dobool,			\
+			u8           : proc_dou8vec_minmax,		\
+			default      :					\
+					0xdeadbeaf)
+
+/**
+ * __CTL_AUTO_HANDLER_RANGE - select proc_handler for a range-constrained entry
+ *
+ * Supported types: int, unsigned int, long, unsigned long, u8.
+ * bool is also accepted but proc_dobool ignores extra1/extra2 range bounds.
+ *
+ * @__var: kernel variable (value, not address), or SYSCTL_NULL
+ */
+#define __CTL_AUTO_HANDLER_RANGE(__var)					\
+	_Generic((__var),						\
+			int          : proc_dointvec_minmax,		\
+			unsigned int : proc_douintvec_minmax,		\
+			long         : proc_doulongvec_minmax,		\
+			unsigned long: proc_doulongvec_minmax,		\
+			bool         : proc_dobool,			\
+			u8           : proc_dou8vec_minmax,		\
+			default      :					\
+					0xdeadbeaf)
+
+/**
+ * __CTL_PROCNAME - validate and return the procname string
+ *
+ * "" __name "" enforces a string-literal argument at compile time.
+ *
+ * @__name: procname string literal
+ */
+#define __CTL_PROCNAME(__name)    ("" __name "")
+
+/**
+ * __CTL_DATA - assert __var is addressable; return its address
+ *
+ * SYSCTL_NULL -> (void *)NULL
+ * lvalue __var -> (void *)&(__var)
+ *
+ * @__var: kernel variable (without &), or SYSCTL_NULL
+ */
+#define __CTL_DATA(__var)						\
+	_Generic((__var),						\
+			struct _sysctl_null_type : (void *)NULL,	\
+			default :					\
+				 (void *)&(__var))
+
+/* Compute maxlen for NULL entries: use explicit MAXLEN if >0, else 0 */
+#define __SYSCTL_MAXLEN_NULL(__maxlen)					\
+	((__maxlen) > 0 ? (size_t)(__maxlen) : (size_t)0)
+
+/* Compute maxlen: use explicit MAXLEN if >0, else sizeof(VAR) */
+#define __SYSCTL_MAXLEN_VAR(__var, __maxlen)				\
+	((__maxlen) >= 0 ? (size_t)(__maxlen) : (size_t)sizeof(__var))
+
+/**
+ * __CTL_MAXLEN - compute the .maxlen value
+ *
+ * @__var:    kernel variable (without &), or SYSCTL_NULL
+ * @__maxlen: explicit override, or -1 for auto-sizing
+ */
+#define __CTL_MAXLEN(__var, __maxlen)					\
+	_Generic((__var),						\
+			struct _sysctl_null_type :			\
+				__SYSCTL_MAXLEN_NULL(__maxlen),		\
+			default :					\
+				__SYSCTL_MAXLEN_VAR(__var, __maxlen)	\
+		)
+
+/**
+ * __CTL_MODE - validate and return file permission bits
+ *
+ * @__mode: file permission bits (e.g. 0644)
+ */
+#define __CTL_MODE(__mode)    (0 ? (umode_t)0 : (__mode))
+
+/**
+ * __CTL_HANDLER - validate and return proc_handler
+ *
+ * @__handler: proc_handler
+ */
+#define __CTL_HANDLER(__handler) \
+	(0 ? (typeof(proc_handler) *)0 : (__handler))
+
+/* Validate PTR is pointer-compatible and return it as void* */
+#define __CTL_EXTRA(PTR) \
+		(0 ? (void *)0 : (PTR))
+
+/**
+ * Internal primitive  (single source of truth)
+ *
+ * All public macros delegate here.
+ *
+ * @_var:     kernel variable (without &), or SYSCTL_NULL
+ * @_name:    procname string literal
+ * @_mode:    file permission bits
+ * @_handler: proc_handler-compatible function pointer
+ * @_min:     lower bound pointer, or NULL
+ * @_max:     upper bound pointer, or NULL
+ * @_maxlen:  explicit .maxlen, or -1 for auto-sizing
+ */
+#define __CTLTBL_ENTRY(_var, _name, _mode, _handler, _min, _max, _maxlen) \
+{ \
+	.procname     = __CTL_PROCNAME(_name),				\
+	.data         = __CTL_DATA(_var),				\
+	.maxlen       = __CTL_MAXLEN(_var, _maxlen),			\
+	.mode         = __CTL_MODE(_mode),				\
+	.proc_handler = __CTL_HANDLER(_handler),			\
+	.poll         = NULL,						\
+	.extra1       = __CTL_EXTRA(_min),				\
+	.extra2       = __CTL_EXTRA(_max),				\
+}
+
+/**
+ * Public API
+ *
+ * Naming convention:
+ *   V  - Variable is auto-named via #__var
+ *   N  - explicit Name string
+ *   M  - explicit Mode
+ *   H  - explicit Handler
+ *   R  - Range checking (min/max, selects _minmax handler)
+ *   L  - explicit Length (.maxlen override)
+ */
+
+/**
+ * CTLTBL_ENTRY_V - read-only entry; procname == stringified variable name
+ *
+ * Proto: (T __var)
+ *
+ * .procname = #__var, .mode = 0444, .extra1 = .extra2 = NULL.
+ * proc_handler and .maxlen inferred from typeof(__var).
+ *
+ * @__var: kernel variable (without &); must be an addressable lvalue
+ */
+#define CTLTBL_ENTRY_V(__var)						\
+	__CTLTBL_ENTRY(__var, #__var, 0444,				\
+		__CTL_AUTO_HANDLER(__var), NULL, NULL, -1)
+
+/**
+ * CTLTBL_ENTRY_VM - entry with custom mode; procname == #__var
+ *
+ * Proto: (T __var, umode_t __mode)
+ *
+ * @__var:  kernel variable (without &)
+ * @__mode: file permission bits
+ */
+#define CTLTBL_ENTRY_VM(__var, __mode)					\
+	__CTLTBL_ENTRY(__var, #__var, __mode,				\
+		__CTL_AUTO_HANDLER(__var), NULL, NULL, -1)
+
+/**
+ * CTLTBL_ENTRY_VMR - custom mode with range checking; procname == #__var
+ *
+ * Proto: (T __var, umode_t __mode, T *__min, T *__max)
+ *
+ * @__var:  kernel variable (without &)
+ * @__mode: file permission bits
+ * @__min:  pointer to minimum value; typeof(*__min) must == typeof(__var)
+ * @__max:  pointer to maximum value; typeof(*__max) must == typeof(__var)
+ */
+#define CTLTBL_ENTRY_VMR(__var, __mode, __min, __max)			\
+	__CTLTBL_ENTRY(__var, #__var, __mode,				\
+		__CTL_AUTO_HANDLER_RANGE(__var), __min, __max, -1)
+
+/**
+ * CTLTBL_ENTRY_VN - read-only entry with explicit procname
+ *
+ * Proto: (T __var, const char *__name)
+ *
+ * @__var:  kernel variable (without &)
+ * @__name: procname string literal
+ */
+#define CTLTBL_ENTRY_VN(__var, __name)					\
+	__CTLTBL_ENTRY(__var, __name, 0444,				\
+		__CTL_AUTO_HANDLER(__var), NULL, NULL, -1)
+
+/**
+ * CTLTBL_ENTRY_VNM - entry with explicit procname and mode
+ *
+ * Proto: (T __var, const char *__name, umode_t __mode)
+ *
+ * @__var:  kernel variable (without &)
+ * @__name: procname string literal
+ * @__mode: file permission bits
+ */
+#define CTLTBL_ENTRY_VNM(__var, __name, __mode)				\
+	__CTLTBL_ENTRY(__var, __name, __mode,				\
+		__CTL_AUTO_HANDLER(__var), NULL, NULL, -1)
+
+/**
+ * CTLTBL_ENTRY_VNMH - entry with explicit procname, mode and handler
+ *
+ * Proto: (T __var, const char *__name, umode_t __mode,
+ *         proc_handler *__handler)
+ *
+ * @__var:     kernel variable (without &), or SYSCTL_NULL
+ * @__name:    procname string literal
+ * @__mode:    file permission bits
+ * @__handler: proc_handler-compatible function pointer
+ */
+#define CTLTBL_ENTRY_VNMH(__var, __name, __mode, __handler)		\
+	__CTLTBL_ENTRY(__var, __name, __mode, __handler, NULL, NULL, -1)
+
+/**
+ * CTLTBL_ENTRY_VNMR - entry with procname, mode and range checking
+ *
+ * Proto: (T __var, const char *__name, umode_t __mode,
+ *         T *__min, T *__max)
+ *
+ * @__var:  kernel variable (without &)
+ * @__name: procname string literal
+ * @__mode: file permission bits
+ * @__min:  pointer to minimum value; typeof(*__min) must == typeof(__var)
+ * @__max:  pointer to maximum value; typeof(*__max) must == typeof(__var)
+ */
+#define CTLTBL_ENTRY_VNMR(__var, __name, __mode, __min, __max)		\
+	__CTLTBL_ENTRY(__var, __name, __mode,				\
+		__CTL_AUTO_HANDLER_RANGE(__var), __min, __max, -1)
+
+/**
+ * CTLTBL_ENTRY_VNMHR - entry with explicit handler and range
+ *
+ * Proto: (T __var, const char *__name, umode_t __mode,
+ *         proc_handler *__handler, T *__min, T *__max)
+ *
+ * @__var:     kernel variable (without &), or SYSCTL_NULL
+ * @__name:    procname string literal
+ * @__mode:    file permission bits
+ * @__handler: proc_handler-compatible function pointer
+ * @__min:     pointer to minimum value for .extra1
+ * @__max:     pointer to maximum value for .extra2
+ */
+#define CTLTBL_ENTRY_VNMHR(__var, __name, __mode, __handler, __min, __max) \
+	__CTLTBL_ENTRY(__var, __name, __mode, __handler, __min, __max, -1)
+
+/**
+ * CTLTBL_ENTRY_VNMHRL - fully explicit entry
+ *
+ * Proto: (T __var, const char *__name, umode_t __mode,
+ *         proc_handler *__handler, T *__min, T *__max,
+ *         size_t __maxlen)
+ *
+ * Pass -1 for __maxlen to use sizeof(__var) / 0 (auto).
+ * Pass  0 to set .maxlen to zero explicitly.
+ *
+ * @__var:     kernel variable (without &), or SYSCTL_NULL
+ * @__name:    procname string literal
+ * @__mode:    file permission bits
+ * @__handler: proc_handler-compatible function pointer
+ * @__min:     pointer to minimum value for .extra1
+ * @__max:     pointer to maximum value for .extra2
+ * @__maxlen:  explicit value for .maxlen
+ */
+#define CTLTBL_ENTRY_VNMHRL(__var, __name, __mode, __handler,		\
+			    __min, __max, __maxlen)			\
+	__CTLTBL_ENTRY(__var, __name, __mode, __handler, __min, __max, __maxlen)
+
+/**
+ * CTLTBL_ENTRY_NMH - custom-handler entry with no associated variable
+ *
+ * Proto: (const char *__name, umode_t __mode,
+ *         proc_handler *__handler)
+ *
+ * Shorthand for CTLTBL_ENTRY_VNMH(SYSCTL_NULL, ...).
+ * .data = NULL, .maxlen = 0, .extra1 = NULL, .extra2 = NULL.
+ *
+ * @__name:    procname string literal
+ * @__mode:    file permission bits
+ * @__handler: proc_handler-compatible function pointer
+ */
+#define CTLTBL_ENTRY_NMH(__name, __mode, __handler)			\
+	CTLTBL_ENTRY_VNMH(SYSCTL_NULL, __name, __mode, __handler)
+
 struct ctl_node {
 	struct rb_node node;
 	struct ctl_table_header *header;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9d3a666ffde1..121e743e7709 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -29,6 +29,8 @@ EXPORT_SYMBOL(sysctl_vals);
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
 EXPORT_SYMBOL_GPL(sysctl_long_vals);
 
+const struct _sysctl_null_type _sysctl_null_marker;
+
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and maximum */
-- 
2.25.1


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF5381AFF;
	Sat,  9 May 2026 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778306230; cv=none; b=o+aBnKhN/jOKyWelzMhIaCY73+s2Cl9EA+Ki0k95p6zSVgmWP0eaftfvDbdSUh2+v09yyJHIC1T0h4kdLI27gRvXoINoffwXr6kBbz4DKiVt2BLWfSJRq2pcqgMLoP5cewCbla64isIAAGFbYr89knlTddhhxjppXyfMmZ4yVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778306230; c=relaxed/simple;
	bh=5ddTeygHBwyTcRQbXeAonaLz3kIADPbI6jiIlj3mCB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9sSiWTseVKhBt9sWLBQajQOjYhdTwkCwdU+w3ldT1b7WJ1LlH4QEfaiSFmZqjePggVqUcpYz4dVHuL70gY27+Bs7/kI79qjRmjAqw0oGHpZ3GHHdj1EKnl+bZBMWPYlrl9iZYk+Vp37osnfSBljaThjAdwOGVC5VHsuK5wJleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VcNgNYqu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VcNgNYqu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ehrfcN5Fo8wXpxrQ7bxESmYilMYB52ib/trW7BH+Fzw=; b=VcNgNYquz3jK/YJ/FkdzQ8mXZm
	b3GIS6eGVUw3K9Lx7F0Go+G9bLqDc7HlZcFnkWR7yQvvO7kTyX6ANqrBmTAdpuoj+Z25Cvya8cCWr
	pfZqrOOo/gJN8LYCTsvjmTONFcGHPDY0YKHVcNHlkDUejJUlIK1wUbYOKHGo2m9uHZQwNJ99n6/GP
	TBHaQNkn88YjdpmbsID/7DuTI92LGr/z3SZ+9Y77DRdxoiZj36uPkv1kMPzikrwx4gZHFgoHKHzWW
	ydfYE21ky++McbULwRDBMj5pUO5HT8Qymz9xbp2WitOmZEIAyhZpq3RSEuJaNSHvwTehBd+V7eVb6
	OZ6kapOQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLagO-00000008Liq-1WcY;
	Sat, 09 May 2026 05:57:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] sysctl: add Returns: kernel-doc for all functions
Date: Fri,  8 May 2026 22:56:58 -0700
Message-ID: <20260509055658.1089994-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings in kernel/sysctl.c by adding Returns:
clauses for them.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org

 kernel/sysctl.c |   45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

--- linux-next-20260508.orig/kernel/sysctl.c
+++ linux-next-20260508/kernel/sysctl.c
@@ -148,7 +148,7 @@ static void warn_sysctl_write(const stru
  * @ppos: file position
  * @table: the sysctl table
  *
- * Returns true if the first position is non-zero and the sysctl_writes_strict
+ * Returns: true if the first position is non-zero and the sysctl_writes_strict
  * mode indicates this is not allowed for numeric input types. String proc
  * handlers can ignore the return value.
  */
@@ -184,7 +184,7 @@ static bool proc_first_pos_non_zero_igno
  * and a newline '\n' is added. It is truncated if the buffer is
  * not large enough.
  *
- * Returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_dostring(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
@@ -225,11 +225,14 @@ static void proc_skip_char(char **buf, s
  * @base: the base to use
  * @res: where the parsed integer will be stored
  *
- * In case of success 0 is returned and @res will contain the parsed integer,
- * @endp will hold any trailing characters.
  * This function will fail the parse on overflow. If there wasn't an overflow
  * the function will defer the decision what characters count as invalid to the
  * caller.
+ *
+ * Returns:
+ * * %0 on success and @res will contain the parsed integer,
+ *   @endp will hold any trailing characters.
+ * * %-ERANGE on overflow.
  */
 static int strtoul_lenient(const char *cp, char **endp, unsigned int base,
 			   unsigned long *res)
@@ -263,10 +266,12 @@ static int strtoul_lenient(const char *c
  * @perm_tr_len: size of the perm_tr vector
  * @tr: pointer to store the trailer character
  *
- * In case of success %0 is returned and @buf and @size are updated with
- * the amount of bytes read. If @tr is non-NULL and a trailing
- * character exists (size is non-zero after returning from this
- * function), @tr is updated with the trailing character.
+ * Returns:
+ * * %0 on success and @buf and @size are updated with
+ *   the amount of bytes read. If @tr is non-NULL and a trailing
+ *   character exists (size is non-zero after returning from this
+ *   function), @tr is updated with the trailing character.
+ * * %-EINVAL on failure.
  */
 static int proc_get_long(char **buf, size_t *size,
 			  unsigned long *val, bool *neg,
@@ -365,7 +370,7 @@ static void proc_put_char(void **buf, si
  * not NULL. Check that the values are less than UINT_MAX to avoid
  * having to support wrap around from userspace.
  *
- * returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
 			   ulong (*u_ptr_op)(const ulong))
@@ -386,7 +391,7 @@ int proc_uint_u2k_conv_uop(const ulong *
  *
  * Uses READ_ONCE to assign value to u_ptr.
  *
- * returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr)
 {
@@ -409,7 +414,7 @@ int proc_uint_k2u_conv(ulong *u_ptr, con
  * When direction is kernel to user, then the u_ptr is modified.
  * When direction is user to kernel, then the k_ptr is modified.
  *
- * Returns 0 on success
+ * Returns: %0 on success
  */
 int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
 		   const struct ctl_table *tbl, bool k_ptr_range_check,
@@ -774,7 +779,7 @@ static int do_proc_douintvec(const struc
  * values from/to the user buffer, treated as an ASCII string. Negative
  * strings are not allowed.
  *
- * Returns 0 on success
+ * Returns: %0 on success
  */
 int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
 			size_t *lenp, loff_t *ppos,
@@ -798,7 +803,7 @@ int proc_douintvec_conv(const struct ctl
  * table->data must point to a bool variable and table->maxlen must
  * be sizeof(bool).
  *
- * Returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
@@ -835,7 +840,7 @@ int proc_dobool(const struct ctl_table *
  * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
  * values from/to the user buffer, treated as an ASCII string.
  *
- * Returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
@@ -854,7 +859,7 @@ int proc_dointvec(const struct ctl_table
  * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
  * values from/to the user buffer, treated as an ASCII string.
  *
- * Returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
@@ -877,7 +882,7 @@ int proc_douintvec(const struct ctl_tabl
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success or -EINVAL when the range check fails and
+ * Returns: %0 on success or -EINVAL when the range check fails and
  * SYSCTL_USER_TO_KERN(dir) == true
  */
 int proc_dointvec_minmax(const struct ctl_table *table, int dir,
@@ -904,7 +909,7 @@ int proc_dointvec_minmax(const struct ct
  * (max). And Check that the values are less than UINT_MAX to avoid having to
  * support wrap around uses from userspace.
  *
- * Returns 0 on success or -ERANGE when range check failes and
+ * Returns: %0 on success or -ERANGE when range check failes and
  * SYSCTL_USER_TO_KERN(dir) == true
  */
 int proc_douintvec_minmax(const struct ctl_table *table, int dir,
@@ -929,7 +934,7 @@ int proc_douintvec_minmax(const struct c
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success or an error on SYSCTL_USER_TO_KERN(dir) == true
+ * Returns: %0 on success or an error on SYSCTL_USER_TO_KERN(dir) == true
  * and the range check fails.
  */
 int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
@@ -1061,7 +1066,7 @@ int proc_doulongvec_minmax_conv(const st
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 			   void *buffer, size_t *lenp, loff_t *ppos)
@@ -1108,7 +1113,7 @@ int proc_dointvec_conv(const struct ctl_
  * large bitmaps may be represented in a compact manner. Writing into
  * the file will clear the bitmap then update it with the given input.
  *
- * Returns 0 on success.
+ * Returns: %0 on success.
  */
 int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 			 void *buffer, size_t *lenp, loff_t *ppos)

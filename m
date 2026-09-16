Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BA495ADA;
	Wed, 16 Sep 2026 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576504; cv=none; b=ECI5541sS4r5ea7m6fbN4HXQl4Pd2UIMDMaG5PNFpNm3wqLZheso8jBZe84KbDLAMPgGptc9xsNv5pOhRlTxjBXxnb31Sa+UQisjyh/kRYkP0beaiQGLydbbnm6cZJpkV8TNRT+wYMhzRC8F6qNmc52akGCi6kWDlbLOOMRXMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576504; c=relaxed/simple;
	bh=VwFNI6/7CDbLpIgbrA2FvbFm9cHagLP4+yu+czc8LIo=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=HVaMIdp2Tb+pQEw8LGDy2HjwSnK3Lb5mdVM3YChL8Sx6mDokwEMGA1P/1LPClyAz3Q+RTkEGxEHjrgpDEe9hV6d897nHYmaK3qGudzb80/iqLA56P92DbwIbpSgEF6/OZ0L69LAnyfp50nghyzjyJGnp6H59EVNE+8gBeY1x/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=aY/OhHzd; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sYi6gYY+; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="aY/OhHzd";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sYi6gYY+"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789576483; bh=asvvqezsk0xdwWXAIJR1xyj
	WRr4hzYflU1xpxJJzlQw=; b=aY/OhHzdEzJVN9O0/JvTyfDM/qAVy2/bmF6zphlE8u4rR8Utp3
	5YIyCdIOyhG+pkJqX/BoRW0ZEvvc6r8dyxCJZiapPt4MVDrWjt+0WCe4bXqwOMzZoBnl9pe2uHg
	RytT2ROfkoTbVmWDgTpKRJn7gzLSVhnVIn/sCYGceCigHhK/C1Sziako4twALr0q7LZDukGOY/i
	Z70JQ/1S/EughJOwf6KJuCIcuP/ZNLGH8svdtiJwIthi4/GjyuOjG3hFMlL6dfkang9UR9zITa/
	A2hMsolRzg3F7/ksMPmVYmAfbaugfpe6GftOgFVj8mOT+N8jOt8YTfrg2JApiBJWQtA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789576483; bh=asvvqezsk0xdwWXAIJR1xyj
	WRr4hzYflU1xpxJJzlQw=; b=sYi6gYY+Nq33pisneyhiC0kmbaii2zlRVF8kY0q6zUa25gGLEr
	FXrmJCHf1/k1N8UawHeuPUjea9ANPlhYUYBw==;
Date: Wed, 16 Sep 2026 17:34:44 +0100
From: Bradley Morgan <brads@mainlining.org>
To: joel.granados@kernel.org
CC: include@grrlz.net, kees@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Use replace **void with **char in proc_put_*
In-Reply-To: <20260916-lklm-sysctl-void-vs-char-v1-1-c3f8b2eb8b1e@kernel.org>
Message-ID: <BEC35EDB-CFB7-4F33-ABA4-6669D053148F@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 September 2026 12:44:28 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>Replace **void argument with **char in the proc_put_* functions. These
>are leftovers from before commit 32927393dc1c ("sysctl: pass kernel
>pointers to ->proc_handler") where a cast to char __user** from void
>_user** was needed before the put_user call.
>
>Suggested-by: Bradley Morgan <include@grrlz.net>
>Signed-off-by: Joel Granados <joel.granados@kernel.org>
>---
> kernel/sysctl.c | 34 +++++++++++++++-------------------
> 1 file changed, 15 insertions(+), 19 deletions(-)
>
>diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>index 25577ffc2801267cc69df60a1064ada9efd4b97d..1fefe18bf84e790433a1abf71a4b158f3c1f729f 100644
>--- a/kernel/sysctl.c
>+++ b/kernel/sysctl.c
>@@ -332,7 +332,7 @@ static int proc_get_long(char **buf, size_t *size,
>  * In case of success @buf and @size are updated with the amount of bytes
>  * written.
>  */
>-static void proc_put_long(void **buf, size_t *size, unsigned long val, bool neg)
>+static void proc_put_long(char **buf, size_t *size, unsigned long val, bool neg)
> {
> 	int len;
> 	char tmp[TMPBUFLEN], *p = tmp;
>@@ -347,15 +347,12 @@ static void proc_put_long(void **buf, size_t *size, unsigned long val, bool neg)
> }
> #undef TMPBUFLEN
> 
>-static void proc_put_char(void **buf, size_t *size, char c)
>+static void proc_put_char(char **buf, size_t *size, char c)
> {
> 	if (*size) {
>-		char **buffer = (char **)buf;
>-		**buffer = c;
>-
>+		**buf = c;
> 		(*size)--;
>-		(*buffer)++;
>-		*buf = *buffer;
>+		(*buf)++;
> 	}
> }
> 
>@@ -680,12 +677,12 @@ static int apply_conv_on_vec(const union proc_vec_conv conv,
> 			     const struct ctl_table *table,
> 			     const enum proc_vec_type data_type,
> 			     const size_t data_size, const int conv_dir,
>-			     const size_t buf_nbyte, void *buf,
>+			     const size_t buf_nbyte, char *buf,
> 			     size_t *buf_left_final)
> {
> 	int vec_left, err = 0;
> 	size_t buf_left, nr_conv = 0;
>-	char *data, *data_stage = NULL, *p;
>+	char *data, *data_stage = NULL;
> 	bool is_unsigned = data_type == PROC_VEC_UINT || data_type == PROC_VEC_ULONG;
> 
> 	buf_left = buf_nbyte;
>@@ -694,7 +691,6 @@ static int apply_conv_on_vec(const union proc_vec_conv conv,
> 	if (SYSCTL_USER_TO_KERN(conv_dir)) {
> 		if (buf_left > PAGE_SIZE - 1)
> 			buf_left = PAGE_SIZE - 1;
>-		p = buf;
> 
> 		if (table->maxlen > data_size) {
> 			data_stage = kmemdup(table->data, table->maxlen, GFP_KERNEL);
>@@ -712,11 +708,11 @@ static int apply_conv_on_vec(const union proc_vec_conv conv,
> 		bool neg = false;
> 
> 		if (SYSCTL_USER_TO_KERN(conv_dir)) {
>-			proc_skip_spaces(&p, &buf_left);
>+			proc_skip_spaces(&buf, &buf_left);
> 
> 			if (!buf_left)
> 				break;
>-			err = proc_get_long(&p, &buf_left, &lval, &neg,
>+			err = proc_get_long(&buf, &buf_left, &lval, &neg,
> 					    proc_wspace_sep,
> 					    sizeof(proc_wspace_sep), NULL);
> 			if (!err && neg && is_unsigned)
>@@ -740,7 +736,7 @@ static int apply_conv_on_vec(const union proc_vec_conv conv,
> 
> 	if (SYSCTL_USER_TO_KERN(conv_dir)) {
> 		if (!err && buf_left)
>-			proc_skip_spaces(&p, &buf_left);
>+			proc_skip_spaces(&buf, &buf_left);
> 		if (!nr_conv) {
> 			err = err ? : -EINVAL;
> 			goto out;
>@@ -1221,6 +1217,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
> 	unsigned long *bitmap = *(unsigned long **) table->data;
> 	unsigned long *tmp_bitmap = NULL;
> 	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c = 0;
>+	char *p = buffer;
> 
> 	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(dir))) {
> 		*lenp = 0;
>@@ -1228,7 +1225,6 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
> 	}
> 
> 	if (SYSCTL_USER_TO_KERN(dir)) {
>-		char *p = buffer;
> 		size_t skipped = 0;
> 
> 		if (left > PAGE_SIZE - 1) {
>@@ -1315,16 +1311,16 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
> 						   bit_a + 1) - 1;
> 
> 			if (!first)
>-				proc_put_char(&buffer, &left, ',');
>-			proc_put_long(&buffer, &left, bit_a, false);
>+				proc_put_char(&p, &left, ',');
>+			proc_put_long(&p, &left, bit_a, false);
> 			if (bit_a != bit_b) {
>-				proc_put_char(&buffer, &left, '-');
>-				proc_put_long(&buffer, &left, bit_b, false);
>+				proc_put_char(&p, &left, '-');
>+				proc_put_long(&p, &left, bit_b, false);
> 			}
> 
> 			first = 0; bit_b++;
> 		}
>-		proc_put_char(&buffer, &left, '\n');
>+		proc_put_char(&p, &left, '\n');
> 	}
> 
> 	if (!err) {
>
>---
>base-commit: 99156fbf3562bed74aa57d93b0b3eeec7c7f1ca6
>change-id: 20260916-lklm-sysctl-void-vs-char-40a0aab31c3e
>
>Best regards,
>
Hmm, looks okay 

Reviewed-by: Bradley Morgan <brads@mainlining.org>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

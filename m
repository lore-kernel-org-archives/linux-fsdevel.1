Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB19337BA1
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774174474; cv=none; b=fe+RVD+ZyMGNLvACmt4BDkkcTGs0iHg9SWoWywR6IRAjHAsoskrI0Ad8QH9o9lUaCOS3nn1hRsOuanoc5EP23BrBaspI+ZepS21KypTWjO+j6cceVcSFmMtnG63APCZu86WwI4Fa1Kfq9Dqlb8QruLXkNEP3oUjmaa4rpbS2Zcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774174474; c=relaxed/simple;
	bh=GGRFlnYlX0TJ4Gp1gd382uqm1+mgkoA7AHvyjincDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUS4Z+VlyMRKPftSaeKUWHcUCSXkhluheLqUeNE5llqg48DNJsEG3v+oYFQUcaeYSdxJc8Xt7HMnqFUavnOhnx9wy9xnOpTg2H5HmPJdc1MiqMOeNVRvv6jCBKr8oVOaeL6CoNHSXxNtcE6vlIM0r7t0ttyg6AeUuwMfpkv7zH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=F0vqg5s7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F0vqg5s7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-487012ce896so9184045e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1774174472; x=1774779272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS92Oz5ll9Nuuusd+zVQ+h8b6wJizU7l2ybhrjswmN0=;
        b=F0vqg5s7vOkfbZ2tJsgqd8ilpm6DE8O1BLXHVaHSBhiIRHlB20CSmNZTq2rAZIN2jU
         t8psiVS4TaOh4BlB+A0HIKOwoDng/72NnPZZnxNGXM6N0JI6QihLxCDs89yfgfkEzcfn
         EO32uKnCOrwm98zrjjlS/1GsHqGAk+n9jUjnbliRbNawibg5goP22XgWaEebiLYoghhF
         5pDbhgRf1Sh6LHapjbGLsOB8+V8Asprw7PHZkbhukSAcDEuBjjFGPc+SNyuMcBdgJp8o
         n2CBqnq2C7ez3b5xubaXZZuZQK+nmu9kPFllqo2HNyzIcdkZKRP8VOhLpC3doNXfekxI
         gJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774174472; x=1774779272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YS92Oz5ll9Nuuusd+zVQ+h8b6wJizU7l2ybhrjswmN0=;
        b=dHNgcIAqOmlKfnDt2DIJ27asVZB1Ubhz4BFu74W96sunkpRqSRZazVXchBseW4+8HE
         cBD36lURqEupbU+0BMXg44GnXBuNu0KObrgzvkjaewwcL//jSB2gIaT+RsWXy09aZqR8
         xbg3oHrFae3N1NrtEmChnt8McIPYIIUKxdyrjvdspdDcGFACK21OOxdPEMIE7zq8dMMd
         IJfsQQYfmulG+DiyeJvI+C7dx78wQJnCth5aUexAjOx72YGXJ+2PRYAhpWCHHghtfw4N
         P43qemdQZT5lafH/uAexk/32LUsg/uaDZFfkf6OwNv8VIU4wwa2Fg4Hil1j2EaCU1Q7H
         SnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfW9pZaGOltRhZh4y4KXZ+J5QuAO6kvVQ+IvUdAchnDc+mGPf76cvVQH9rlktCxophQcv69i1oncsPQsh2@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJ1FpG3FUwNZ2oPP6dgO367GsVh3Y6SO59zJDSWvU6etFCJAM
	XTOW5yeKXoernxgGqOtEs8JoHEjPpE/9SWl0/bMNGcLEPmQCOX27UQLVi6zW1KPN
X-Gm-Gg: ATEYQzzNB4hZC99xOYpHtQhUef5A3QeG3E0/5IaHS7nWl01rb11XJJaKCjemW9Fcwsz
	Orv2qkMHw+ttiWnsln0MFdaOcYahN39nhr1G5bbPUMo94e31W8XmwG0dPGvfZyQDo61V+jC4kL0
	fQKcj/XGvaq2w4Y4gZRGV8C1ZSxOk9OZJXBB0X7nvqvw72U4YjENirvWLMQ/h7f/lMamd3zo7V4
	IMvUVy6+Kv6ajbvd+H9RMCX5eb98xEkfimk7TrsXN3di97Itt0Zc84v1kIJ1V2AU5Sicy78PzCF
	zB/8sZcpfLtFHMrcQc8R76INbvWmC5ND4NRAzSQpyhpA5sWz7ZAblP7harP/dydQlFhAuuJZvRK
	Bz/lP7CTX/807b51tRDa9Dabe8EerD4OGlQrJmYPqPGnoHWwhuFQkPHVZX1Cz3iZIvoDN3ZcheX
	er/GuB5hHlc4oYZXKx58sxSDv8v6nyJOq0baWwv0fKeIk=
X-Received: by 2002:a05:600c:c8a:b0:485:4453:401d with SMTP id 5b1f17b1804b1-486fede7336mr125853305e9.2.1774174471574;
        Sun, 22 Mar 2026 03:14:31 -0700 (PDT)
Received: from ccde1gl2920.wdf.sap.corp ([130.214.226.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm217119495e9.2.2026.03.22.03.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 03:14:31 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
To: ps.report@gmx.net
Cc: buermarc@googlemail.com,
	davem@davemloft.net,
	elias.rw2@gmail.com,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in proc_do_large_bitmap
Date: Sun, 22 Mar 2026 11:13:05 +0100
Message-ID: <20260322101305.82609-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321130526.207666c0@pc-1>
References: <20260321130526.207666c0@pc-1>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter, Hi Kees,

Thanks for your responses.

On Fri, 20 Mar 2026 11:30:29 -0700, Kees Cook <kees@kernel.org> wrote:

> Please don't include "---" as a separator here: we want to keep your
> entire commit log (including the SoB and other tags).

Ah, sorry, I will fix that. I guess the SoB and tags have to go into the actual
commit message and not into the cover letter of b4. My understanding is that
additional bug information can be kept where it is, but the tags must be within
the commit message.

On Sat, 21 Mar 2026 13:05:26 +0100, Peter Seiderer wrote:

> > Also, I think the explicit zero-init of 'c' would be nice to keep just
> > for robustness: the compiler can elide it if it decides it's a duplicate
> > store. There's only upside to including it.
> 
> Sorry, disagree on this one, not a fan of this 'add unneeded code just in =
> case...'
> pattern hiding the real fix and/or logic of the code, but just the
> opinion of a sporadic contributor ;-)
> 
> @Marc: in case you go this way, please remove my Reviewed-by tag on next
> patch iteration...

I think I have to revisit the fix in general. I did read the review from
shasiko [1] and adding only the left check will not return an -EINVAL for a
trailing dash, e.g. '123-' would return 0 and set the bitmap to 123. Previously
this would return -EINVAL. I added a local test to kernel/sysctl-test.c to
verify this.

The problem is that if left is non zero we advance the pointer and reduce left
after the proc_get_long() call. Normally if we had a trailing dash we would
take the second proc_get_long() call and receive an -EINVAL if nothing is
present anymore. So even if we have a trailing character, left will not be a
correct indicator anymore when we want to check c.

We could either not check left and rely on just c = 0, or introduce a new
variable that stores the information that c has been filled. I will have to
think some more about it, but wanted to already share the finding.

I will provide a new patch at some point, but will think a bit more about
anything I have missed. Until then I tried to send this response in form of a
format patch to provide the test and changes for better understanding. The
patch was created with 80234b5ab240f52fa45d201e899e207b9265ef91 as the parent
similar to PATCH v3.

Best Regards,
Marc

[1] https://sashiko.dev/#/patchset/20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09%40googlemail.com
---
 kernel/sysctl-test.c | 27 +++++++++++++++++++++++++++
 kernel/sysctl.c      |  9 +++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 92f94ea28957..7fc1ed232cd3 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -367,6 +367,32 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+static void
+sysctl_test_proc_do_large_with_invalid_range(struct kunit *test)
+{
+	DECLARE_BITMAP(bitmap, 1024);
+	bitmap_zero(bitmap, 1024);
+
+	unsigned long *bitmap_ptr = bitmap;
+	struct ctl_table test_data = {
+		.data = &bitmap_ptr,
+		.maxlen = 1024,
+	};
+
+	char input[] = "123-";
+	size_t len = sizeof(input) - 1;
+	loff_t pos = 0;
+
+	char *buffer = kunit_kzalloc(test, sizeof(input), GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	memcpy(buffer, input, sizeof(input));
+
+	int result = proc_do_large_bitmap(&test_data, 1, user_buffer, &len, &pos);
+	KUNIT_EXPECT_EQ(test, result, -22);
+	KUNIT_EXPECT_FALSE(test, test_bit(123, bitmap));
+}
+
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +404,7 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_proc_do_large_with_invalid_range),
 	{}
 };
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9d3a666ffde1..041fbc3e73e7 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1118,7 +1118,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
 	unsigned long *tmp_bitmap = NULL;
-	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
+	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c = 0;
 
 	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;
@@ -1143,6 +1143,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 			unsigned long val_a, val_b;
 			bool neg;
 			size_t saved_left;
+			bool trailing_character_set = false;
 
 			/* In case we stop parsing mid-number, we can reset */
 			saved_left = left;
@@ -1158,6 +1159,9 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 				break;
 			}
 
+			if (left)
+				trailing_character_set = true;
+
 			if (err)
 				break;
 			if (val_a >= bitmap_len || neg) {
@@ -1166,12 +1170,13 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 			}
 
 			val_b = val_a;
+
 			if (left) {
 				p++;
 				left--;
 			}
 
-			if (c == '-') {
+			if (trailing_character_set && c == '-') {
 				err = proc_get_long(&p, &left, &val_b,
 						     &neg, tr_b, sizeof(tr_b),
 						     &c);
-- 
2.51.0


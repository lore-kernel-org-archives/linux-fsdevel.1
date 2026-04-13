Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C573CD8BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087089; cv=none; b=KVFFr+8TJXbwyG5FcOHm5g4wbkX93KzhsFO7kPQJ+U0ujHcsKYmigOzL+LU0MYkxqxZOINuo25fksb8pzGsDh6ZtF87uxkQMRxff/iQZX2f7wzhnk6eoPoNeKpOr7Dws0Ag13780+Nn/QO7IQ7blinkFDC0h1hJ58gnMBAgfKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087089; c=relaxed/simple;
	bh=NNF0oOpx6c/FbSF7aZoqGXm3gmeZfZbf1NphjvuVR20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb3g6bFHW9WxKKqBvvBdkz27AwaxhIG2z/nHBd49N+G9tXWh2qTayGWgWjH8oPDvZzt8mdFtPTaziie6oiM71T7k7NRtNlqXpygHGedtCZJa99NwEhuV4PVBirbGkyX+ZMNIAL1NaLNznIsoHDpmdfMTT37zQhdvp7Bep7Mi1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdJ0mhbN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdJ0mhbN"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc3ca1922so405173785a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087087; x=1776691887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cvX/3YS2hK9kgzlNtYASfb57GVegxtYM6rMLbYciK8=;
        b=IdJ0mhbNgApW8d+twXlzX9RhhdTPUYRTkxhGEqsnQqK8FP9UBx3LOyHzZJHEMYDG0w
         k3gANt1nMGhevjhpIVS/sKigAaZVNli9r0O8c//isB9ZeIQ4nPJdMBrsmbR4Taz1LtPG
         OP0BcxUPLqmo85rAkcKbRLVln3Rdb/1RsG2kW53+RZ/Qg5YaJVt6iww8s3RSiUDkDI3S
         AtuDNzdsWLliTUeVauHJ5Y+ebNTBoixrXAGC6ykzmA7A9fyOYZWVxx9yctNJzhiZC8Ni
         o0fHVdFpgk43q07K017vi6sOAcYx1jTH+XlUh1lQQBW4/GxBeKn5I/rybNs0LAs//5VN
         kCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087087; x=1776691887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cvX/3YS2hK9kgzlNtYASfb57GVegxtYM6rMLbYciK8=;
        b=QOB7OlU46F3tRot8UgWEAjwakmsp7Sn59ePL7ne+TUWMfHDA+H7hKvoZLRbpymhfZx
         ERgC/Mhj2c+lsiXVvR0ooSttH3ftRsUER1nXwASswfOMxW/ujquAdwJM1P+9KmgsVeWY
         wn1QZYOie2agGYp4tmGcsvG4TaFRhpq6R9xKnQqnkJsYGOg6KX0iAHm6JGHxaQmGzS1s
         Opv8SP5BAM2IVk33kReSzSWCFfFxv9GPYurAwGDlj6uOk71Ke9zMQUvb6haj1Mgu0Xa4
         l5NuQpKQsw0MqVDXwJ8EVFv4wbS/KKw+5J7V0tL34PYmJQ8lB78ALYQv1M8xK0sHM0Hq
         kg8Q==
X-Forwarded-Encrypted: i=1; AFNElJ99bsc14zWCqqjhMpp0VUTIwaYR+i24n/JVHXnDjVEeoGF4YGfhVoOrr7gLcVCmmSm2yMKAXj094yUr3ySB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0IBir/pp1deDoA07VGk9/9pKUo8sUF8mRFcmk8pQaeTxLaPd
	B67xF6RPS3pxwytb7V/Ibn7s3+yk7tA+ddvcPmvWE/Yut/Mv8S+BJZgs
X-Gm-Gg: AeBDiesRVvdjYfJQPksu7E32F1iafTq2Uogjiid5NEafyauKRetRJAxj8y8Z54xOzw8
	imNV8/E21reK3Y7dulKdyZblT2hbzT60W6kBegEK/xVWYQyNLQxQHBgCd4AEcJLyRa8IyAa3Qp9
	jp7JJ0wR1iUC1BU2MQp9/v8/jI1YoUNKUlO+I2jH/cinSMZ2aaHbElZqcNPE83ui/yT7Miz7YAP
	Dve1IUlAPq9qkTWLhyeE0jfcPN0zsZyki1Emv1jPP7dPPs0maXCLY04BWr28GR8x+k1o2RDq/hG
	Q/XWUzBVhQ0/TCHUPhUM0ZXlbvYGfuLl4O/9KuZZp4HvvPWkAdPSAwLPzSuhz7toYZMfcQoET7O
	jQ844yBEFNUNssGG0fnAWvxkt7oZ9+uVADnVG9sm8dsFyOutrwph9391Mc53nB7jpGdzjaks3On
	XGZhO2wxbFS7SvrQPUeoeMoCZYPHq0JL+f/tNC6lMXRuTU/dn4INygBq/hbvSBRYf95M0bvyR28
	Lu9vsz4G4ob9tu0+HsP
X-Received: by 2002:a05:620a:2892:b0:8d8:ed00:5a90 with SMTP id af79cd13be357-8dc45d29b5bmr2298150385a.23.1776087086763;
        Mon, 13 Apr 2026 06:31:26 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8de6553c460sm852666385a.43.2026.04.13.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:31:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: add depth limit to indx_find_buffer to prevent stack overflow
Date: Mon, 13 Apr 2026 09:31:17 -0400
Message-ID: <20260413133117.3687677-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

indx_find_buffer() recursively descends the B+ tree index with no depth
limit.  A crafted NTFS image with circular index node references causes
unbounded recursion, overflowing the kernel stack and panicking the
system.

This is reachable by mounting a malicious NTFS filesystem (e.g. from a
USB drive via desktop automount) and deleting a file whose index entry
triggers the rebalancing fallback path in indx_delete_entry().

Add a depth parameter and bail out with -EINVAL when it reaches the
fnd->nodes array bound, matching the constraint already enforced by
fnd_push() in indx_find().

The related function indx_find() was previously patched for a similar
infinite-loop issue (commit 1732053c8a6b), but indx_find_buffer() was
missed.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Found during a broader arch/um/ and filesystem security audit.
This is the same class of bug as the one fixed by commit
1732053c8a6b ("fs: ntfs3: check return value of indx_find to
avoid infinite loop"), which added a depth limit to indx_find()
but missed indx_find_buffer().

Reproduced on UML (ARCH=um) with a crafted NTFS image containing
a circular B+ tree directory index. Mounting the image and
deleting a specific file triggers indx_delete_entry() ->
indx_find_buffer() -> unbounded recursion -> stack overflow:

  Kernel panic - not syncing: Kernel tried to access user memory
    at addr 0x606128c4, ip 0x6012907e
  Call Trace:
   [<60611ec2>] ? indx_read_ra+0x0/0x677

At 168+ bytes per frame, ~97 recursions overflow the 16KB kernel
stack. Desktop automount (udisks2 + ntfs3) means a crafted USB
drive can trigger this without privilege.

Note: the pre-existing indx_node allocated by indx_read() during
the DFS is leaked when the new depth limit fires. This is a
pre-existing issue (the node was also leaked on any other error
return from indx_find_buffer); fixing it cleanly requires
restructuring the node ownership model and is left for a
follow-up patch.

Reproducer script and crafted image builder available on request.

 fs/ntfs3/index.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 97f06c26fe1a..2c43e7c27861 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -2013,13 +2013,21 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 					  struct ntfs_inode *ni,
 					  const struct INDEX_ROOT *root,
-					  __le64 vbn, struct indx_node *n)
+					  __le64 vbn, struct indx_node *n,
+					  int depth)
 {
 	int err;
 	const struct NTFS_DE *e;
 	struct indx_node *r;
 	const struct INDEX_HDR *hdr = n ? &n->index->ihdr : &root->ihdr;
 
+	/*
+	 * Limit recursion depth to prevent stack overflow from crafted
+	 * images.  Use the same bound as the fnd->nodes array (20).
+	 */
+	if (depth > ARRAY_SIZE(((struct ntfs_fnd *)NULL)->nodes))
+		return ERR_PTR(-EINVAL);
+
 	/* Step 1: Scan one level. */
 	for (e = hdr_first_de(hdr);; e = hdr_next_de(hdr, e)) {
 		if (!e)
@@ -2040,7 +2048,8 @@ static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
 			if (err)
 				return ERR_PTR(err);
 
-			r = indx_find_buffer(indx, ni, root, vbn, n);
+			r = indx_find_buffer(indx, ni, root, vbn, n,
+					     depth + 1);
 			if (r)
 				return r;
 		}
@@ -2446,7 +2455,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 		fnd_clear(fnd);
 
-		in = indx_find_buffer(indx, ni, root, sub_vbn, NULL);
+		in = indx_find_buffer(indx, ni, root, sub_vbn, NULL, 0);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
 			goto out;
-- 
2.53.0


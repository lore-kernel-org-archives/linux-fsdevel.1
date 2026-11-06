Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964486;
	b=BXsuJPcIjBsg7cBxiCMykTXPwrRwBHIld44ntf8Ja05jq/jaEUnIgfxNhXUUtd7K52yV
	 GuruiKbQ+MNPcSE2CJ5r/BJwVyCvpdokxREczPKOEQ7sB9e4MX3DLdmBHP7hpg/DGgWoh
	 5DRW2wvsJBrCjAwgiR8s+udAzBQyzPO69Z+CXZM7dxke8vlGHKmx6IS7DHeWJDGMCI5aZ
	 ioNoQ79VBY3p7DuUJwFN0++jD/hPcvyw7W6wj6gKGdN51PKCRfhezRtLvu53oWO/C5taT
	 4qPwL/q9unTL+KwfQFZc0g/fTd8JXWcfPU9f83e1tyYA5mZO442SYZXCCWOuOQSNzpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r0oGiXSXqPWt2ut4NcPnn3BOhuEor59O/W/UHXN5XZI=;
	b=U147ZA3aBxEXyjJvMOV3OpU9FSqS6U8IIn8ChqDqbMRA6k6mXFWPtX2z0KWyO+Dh3vue
	 sMLQINNqhMjhFDk2E3WFFGEioeU4PmmUp0Kph2T2uXfNE1n//xya3ems7awPvgsw201yk
	 1buCF3lpdbCw+kvVQ5JDye7UZVHaHiwzlNxXAYIYgH9xON82kL1F8PdcsX5mN3ibod9KW
	 rVZgD/c70g0bUktd2RVtGcTwpARghOD5dGq3JSPotBsjfauTKzGXCg88I5X2y+kkbvBd0
	 RzHAyrF9fEdYd65Lq4kr6eaMk92DWVU4EAJK9ExjQsqc/SDSxA5BCwSFNgiATn3fcgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYrmpEaU;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64F606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 11:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E64F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYrmpEaU
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37071c0f42aso19136eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964485; x=1794569285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0oGiXSXqPWt2ut4NcPnn3BOhuEor59O/W/UHXN5XZI=;
        b=yYrmpEaUTpqnUwnwHY2dg/7LWr5quEGHTcAHtu+t0+dKBO2ED3lkqX2Ji5fGVogG2H
         02utr/jvturPRR4egvfNpGfo+0wHmSxRbihnbQsE6CWlvs3m+MqRJEEL891fqFjDsEjP
         rs9H/PG+8DCmcrE6rS6G1DdmzlNsFnD81vt4A+zAXeGL6JklYk4BewC4h7u+RaBArwvL
         wc8Timc7qPxRzZ9v35ZRW6aulnwMuf9XyC0nsG4KtSTPs+dT/zScMH5iADKMEMZYceL9
         ee6jB/ZX62j/NErthqK5j2Ni8WBpWq363LNWSJmZTeaWwf74v4Ow1x1JuiVTBAqgNWn8
         8Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964485; x=1794569285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0oGiXSXqPWt2ut4NcPnn3BOhuEor59O/W/UHXN5XZI=;
        b=nk/Qp0Y7nGoilaLwPVsM4aU6oKNiELh/BDm22Unk92hUFDaB3vGYUcvGmUaq9wlAt2
         QU9F+MT12Xl4mxIElrVL1Y3VvN62zTev0SGJLiK74e1jEvyrRRMImCy4QReoON9cJE/p
         3QRpa085lhJJpb6N+1X8yU8tX27LwdnaihBNsdCPiYOPyizglZ7WYfpsEZa67Ri7+NVk
         gxYEnbGIezZ2nQHuBXNj8MskZbV3Id/XGoU+uNpU4F6aHHvl3Lz2LqN/Vg/6RsHu4Lrz
         LlItZQSfXuFM+cY5Z2Hp+SDz7F3BpuXyOXq1TRfgNHiY4ZqCpAlnaH/DMitkPoJ/t9Tg
         Fa+A==
X-Forwarded-Encrypted: i=1; AL+hErE9WwvPAzBEvF5UOUQMIog/HHM5R9u5w8m7jF+H917gPv0eHaReHebKLtNIjNs87+uoF58lXO9+yb74ywZQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9yUD2+ZCnDHBI0s/asOdFF74cI5aXukcX00RZ4YGwf/PRFovxk
	kw5tKaFB8RbSW1HmB9B63tvmjGCpl8WLqMH+j2A7ZVtoE/6MF72kY9zJ
X-Gm-Gg: AYBFou1NHl6WUupj8lzmhYk7uKknZdauZTReBVlHcWx/bwmnnG1rGmmPUBw/VYUSCiS
	KvRaKVAiqxcMz4WA+n/ZhLH19GGqSe6+6ikZdBRm8yHmFgoPRxiys71Mlis5WOu1rJkWl4J++W8
	G4/5AK34nBsDf9Sox7PXgux2rj4rM0x+UeFd9t2a128umKBxp8k4vEUWXdWFi2oA/PB2itPt+rZ
	mkIo8pmKJ8Sc219WznMbVgYVZLL42Bd3lF9W7/5/UG3c6M5QO+RixEM1PqjoUF6FOOo8JL9A99C
	6xxyQlI30WlX8rzknqY2JyJjI0JBCoLoUUP/KKawpRs3Z+RUwHGZvaVzMtA7wd6hZN57Vj/do1n
	wp/t1Wl1phlASL9SQkvKxUvnDm4CgkUvh52KzZn6/6p/iA0ockiHhmjElHxy3UT91c1Bjxh843o
	4VZJQefXI/pvXzI1ve5ZlqvwbcE4DvIAmFK7zw9TvVuKF+ZPJJ59IbU3lH+CWk+A9nlR5ZnRNJI
	0m+MavJWCR7yPnWrl4jxex7LX5Fw271ltHaoRZi8nfuhZzGOpAP2l3iQSHGX9ZxxHT3HMWciDBx
	b/qjDlKmgAFJRsS6SHbhE2bTnTITasKWSV1dktoPTmceLTb5qqecdlZhS526ga+HKw==
X-Received: by 2002:a05:7301:4d08:b0:36c:a154:db1d with SMTP id 5a478bee46e88-36f722eabcbmr2881866eec.4.1793964484814;
        Fri, 06 Nov 2026 03:28:04 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b8aacsm6029179eec.23.2026.11.06.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:28:04 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: check the file name against the key length of an index entry
Date: Fri,  6 Nov 2026 16:57:52 +0530
Message-ID: <20261106112752.2552832-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_index_entry_inconsistent() checks that the file name of a
$FILE_NAME key fits in the index entry. It does not check that the name
fits in the key, which is what key_length describes. Code that works on
the key alone relies on that.

ntfs_readdir() copies key_length bytes of the key of the next entry to
resume the enumeration, and later uses the copy to search the index. If
file_name_length is larger than the key holds, the name comparison reads
past the copy:

  BUG: KASAN: slab-out-of-bounds in ntfs_file_compare_values+0x2d1/0x4b0
  Read of size 2 at addr ffff88800a4ef2ce by task init/1
   ntfs_file_compare_values
   ntfs_collate
   ntfs_ie_lookup
   ntfs_index_lookup
   ntfs_readdir
   iterate_dir
  Allocated by task 1:
   kmemdup_noprof
   ntfs_readdir
  The buggy address is located 0 bytes to the right of
  allocated 78-byte region

Two bytes of an image from mkntfs are enough: in an entry whose name has
six characters (key_length 78), change file_name_length from 6 to 7, so
the key claims 80 bytes. The entry itself is 96 bytes, so the existing
check lets it pass. The next readdir of the directory reads the extra
bytes.

Check the name against key_length, and check that the key is large
enough to hold file_name_length in the first place.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
This is independent of the three-patch series I sent earlier today:
https://lore.kernel.org/all/20261106091420.2461683-1-wahidzk0091@gmail.com/

It touches the lines just above the "return -EIO" that
"[PATCH v5 19/31] ntfs: report index validation and block I/O errors"
changes to -EFSCORRUPTED, so one of the two needs a one-line rebase. I am
happy to do it on whichever lands first.

 fs/ntfs/index.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 322cb371d..1abca298a 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -43,9 +43,11 @@ static int ntfs_index_entry_inconsistent(const struct ntfs_volume *vol,
 
 	} else {
 		if (collation_rule == COLLATION_FILE_NAME) {
-			if ((offsetof(struct index_entry, key.file_name.file_name) +
-			     ie->key.file_name.file_name_length	* sizeof(__le16)) >
-					le16_to_cpu(ie->length)) {
+			if (le16_to_cpu(ie->key_length) <
+			    offsetof(struct file_name_attr, file_name) ||
+			    (offsetof(struct file_name_attr, file_name) +
+			     ie->key.file_name.file_name_length * sizeof(__le16)) >
+					le16_to_cpu(ie->key_length)) {
 				ntfs_error(vol->sb,
 					"File name overflow from index entry in inode %lld\n",
 					(long long)inum);
-- 
2.53.0


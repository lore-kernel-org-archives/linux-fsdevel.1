Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D0389DE8
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776113; cv=none; b=W/66rrzpwlZdTtoCCIg8nZAkNVxSv1ID5/lQo/QD00yWmsmGKzLhtjhFTc0tTTqwnawPdHjN3KtscXx9Pn1+VGAQjjyqi5cOZWfOXsIV5yzDop95cU9b9B4GL0PSn+VF4YrG2HGPQCOUrR2YtIjlGHhfCyMQd1vSILqYeBSEIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776113; c=relaxed/simple;
	bh=fO2y9fCGGGybHJ1wc5Dl3NAukTWtgPJuJHMd5feAEdg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qPMOaUA32OGJQ74kAQw4qTSftxxKHCu65Z8cMhBx76KhF41O2mtmUO27FEH9qtYoIKL7Z2i1eHFqo8lAqu4Wq8UDBfiJwnBvyAt0wGFZbx63nkK7EWtXiowmXlNI3hT+sa+LkUn5t4XocWtYphbdOSaZXkGvrwkg19b1Ok6jZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAPuoJ9d; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAPuoJ9d"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1528175a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776112; x=1787380912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+7UlfHt8byW2AkRyMD7to2csfU+ut0KcyznDYmegdDU=;
        b=NAPuoJ9dSXVpJ5Ew5AJ8/lFOL7VveZWvY1mlom9swQyZ9UHBUIHgP8LfrwdYPDgdaJ
         +8sumP50fTU4jFeD4TLx/oyqPCSIH111N7pMF6bkA+LWvOVYRRyT+/VI+J6VG+9uTgaa
         F+2kLjwXou0tXLMX8XwlNdO2o39mDFYDJeq+mre0znVvROj11I6xtmgvUQi3ZUqlLKIA
         DMoSTnV5exVDw9yQ8eMZ+iZdhbnoWpEfWFoOcfQ7qTFjX0Rjj3ZHl1TXdzgVpihojzlF
         ZUfb6v1UGl+OG1ONGnMiirQ1Xx/A7dXETXKaepaU9P6VyJ4Lf5YVPTaqx1OtBPfbYnsM
         tEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776112; x=1787380912;
        h=content-transfer-encoding:content-type:cc:to:subject:from
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7UlfHt8byW2AkRyMD7to2csfU+ut0KcyznDYmegdDU=;
        b=GWAH9AihSQh00RZiGdqoDFgIRuvlLvCC61rABkPlaRTfWKjc5OLs0asnCxLTno1/nu
         n6q3IE8RXD6rfMT5/AP+Kyf5D6DSqKatjUi/r/sxVwleYJUdNRJPV5UcnUf6eOMxjwpV
         GzAbXe5Z6XjcvIZ0+YbuvMDlgidT7fnuWo5byl6QkAJcmo4LidU+O2UJhbkklWXh2UdD
         pzN3EQ9dKR7JMuyrive59fYlbkhpc8qi79F5U96lfoMQOnnuPGoWaA1leaqwPrILVgTA
         FzeBymD3/CQLDaA/tzz30axLFmS3Y2Rwlwpkuw+iFaKnIf+JHngiuRFjebGS8pWxAGpk
         H2PA==
X-Gm-Message-State: AOJu0YxzXZGIwoI1F22+qN0Jd2nhl0Wnx8d/im2H40jUvXdbpWUNLtjR
	cdv5+A1xxP78EnS6O4Y7bEHedsZu6plmHQNYHGq+8BpkYD5OM4rZbxTE24pArGYj1G0=
X-Gm-Gg: AR+sD121pwYgHxAM6gFKMuBRkqTIDICcSjM94ApS3W2R2FXynymEsabKacF0ZIlmwJD
	ZHAC1Zw7DAXJyegSKvHURbvtVuom9yM1Rqjja1Vh3ewNOGQN2uT1i7wKoRr4npsKoIZo/wKXC+9
	QI2TjYHpk+Y9xtiN/Q2o6nkS2LOEF2bpEvTuY7IQAHuEHm8yKhVwc4AVUdNWjpgl/88exi20Dfc
	69V9RIUOfuSNPjvVwVbE+FKrPBqADI7TtzOlV1OwKJFEV2ZM/vNmxOVQ/R5fxgdd+z+A0RCdH+/
	wozWY003k8qVgYLLZTyBkhSEtmWyfNmQUrfsFXv/N1HRnSm5fo20Ev4j8IpkfIMbDkgsKk9J3Ny
	8LKhDRoXR5cifyepdKcZJPANCARv5xCwnNPIvcVqE98pyfMV728aCfJEipNbTVpaAjxEtZhdxnl
	9tvQ7EjjtVLYxjCKmphWkA9QcM5YdvZNpAhorLiP9zivPzS6gsnnYQDXQB+a5GKkmDuzeLk0wsn
	WvJDcyEqKjFRRPZsmIIZFQ2PiYJmcSjUhsXKlQqZjSdQ6gOcJ1jDdCeFCYK3I+t
X-Received: by 2002:a17:90b:3d45:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-3933b9157eemr12870753a91.12.1786776111650;
        Fri, 14 Aug 2026 23:41:51 -0700 (PDT)
Received: from [10.0.1.166] (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebbcbb78sm5582740a91.13.2026.08.14.23.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 23:41:50 -0700 (PDT)
Message-ID: <bcdd72e1-707c-4bcd-94cc-572ba781d00a@gmail.com>
Date: Fri, 14 Aug 2026 23:41:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dennis Tighe <dennis.tighe@gmail.com>
Subject: [PATCH] ntfs: prevent out-of-bounds write from a corrupt runlist
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

For the cluster bitmap ($Bitmap), __ntfs_bitmap_set_bits_in_run() uses a
cluster number as an index into vol->lcn_empty_bits_per_page[] via
ntfs_set_lcn_empty_bits(), with no upper bound on the index.  On the
deallocation path that cluster number is read from an on-disk runlist, so a
corrupted runlist naming a cluster beyond the end of the volume writes past
the end of the array into adjacent memory when a file is freed.

Reject cluster ranges outside the volume before updating the array,
mirroring the nr_clusters check already used in ntfs_trim_fs().

Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---
  fs/ntfs/bitmap.c | 15 +++++++++++++++
  1 file changed, 15 insertions(+)

diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
index b1436b3..fb65bce 100644
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -138,6 +138,21 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, 
const s64 start_bit,
      if (start_bit < 0 || cnt < 0 || value > 1)
          return -EINVAL;

+    /*
+     * For $Bitmap, @start_bit is a cluster number that comes from an
+     * on-disk runlist on the free path.  A corrupt runlist can name a
+     * cluster past the end of the volume and index
+     * vol->lcn_empty_bits_per_page[] out of bounds below, so reject it.
+     */
+    if (ni->mft_no == FILE_Bitmap &&
+        (start_bit >= vol->nr_clusters || cnt > vol->nr_clusters - 
start_bit)) {
+        ntfs_error(vi->i_sb,
+               "Cluster range (0x%llx+0x%llx) outside volume 0x%llx; 
corrupt runlist.",
+               (unsigned long long)start_bit, (unsigned long long)cnt,
+               (unsigned long long)vol->nr_clusters);
+        return -EIO;
+    }
+
      /*
       * Calculate the indices for the pages containing the first and last
       * bits, i.e. @start_bit and @start_bit + @cnt - 1, respectively.
-- 
2.47.3


Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1283D8914
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033127; cv=none; b=dW3MpjwZCr9FLaDhu5zzneO0Gw2N7pXN/zIhJsTGZiJ7KkPom2K0ezv9nCUamyKVwvsZd56nVfdm0fjAhm01T1uvjcL3m0vTXTy81otGiD1WJfz4UiD/NwXo73fEbtjFDtNc7lm31KrRLdf2HiPx3/UERsMcXM1U2/Blm0KcM3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033127; c=relaxed/simple;
	bh=1LkS/G+9OsupplZ6mJRtjAL7b6Sueeo59VtGh/jXl9s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N6NaUWidy+5OOnLdBF5cPxGJmRTPxvQ1Uyf9TxLeQWMEdfWqtk3TM2HKnpexJ7N4NfcM7F4L8sB2rgi3h56YtvxauNTADyicwdNTNxNGpymaScAr54dfeqs30TgOvg14ZGEDyumv/Mok+bGbtE1eaoVz3SzTMppw0COpvgD5GXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwdvM61p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwdvM61p"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-382ef647e20so4086338a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033123; x=1787637923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CSwCC+5VmVEXhaHZ31J0gWRAZYtpFlE4rqplAmPxIF4=;
        b=gwdvM61p/07oTaUN/IFcQaiAMY2g4ewjIhhWfSaCV0fHHTDW7mSKIPFCcNrhZI2RFd
         K6tbdDeon1PVu2uBgMEXm8TyGnNrU0A+J2WOyficLj7HXGgJcbTwMlps5fnOglSddQ2L
         FIdSnMd1LgXi4Whpe8pI7dKzIzTkVkieZvgWibAEKyze4V3eAz79LfDBc3QVaG0M1JJF
         eu/yj1dIsBEyCE/OsMterm7q37m7QygJtCioGlx1xsPRdEgAuOB6GuUXfrP+ZE6AihEb
         1ZixJFPAuGBJs4k3f9sbOKCHW8PR0IdT2YVRFZiothr0jNcGE6jB4WtLhaYsb9PKZuLm
         p8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033123; x=1787637923;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSwCC+5VmVEXhaHZ31J0gWRAZYtpFlE4rqplAmPxIF4=;
        b=HYvROuuGewHcvtsF/8gd0l7s5R0ww1Z38iVWo8Id8NpkjWP+LP+8y78kd/gPx/dbNI
         HWTp/zxm2nGhY7QAu0waezMpaZLLREhQp/sQJJPxeTg1DkfRvFle4HHasq3aPWkJ2qzq
         BgzQ0ALFQU61p4iCezskCXeyBBMEQL4GeF3zFLzN2cDlPU0kDm9KnDNiUfoupLCcG85m
         3iAwG8NZsKsotoFGdAL865C7jeMsvmoSDfvZtIEu8GdZ1NXRGoh/WxwPNldQV8H/kHFc
         K6+tGqThHbZj7kexMmeNT1FlSP1B6ydc1KtBTSyxfquvxsaI3Duh09vAbcvly/LiylwL
         4NRQ==
X-Gm-Message-State: AOJu0Ywj4I0p+zZNjAJu/M2VVrEuvhTbyxruIWlQU8rbGL+orxWZeZZF
	phybdBUeB2Hpgj6jaTmBUS/kUN1E9E/iL2cGPVOftvhnYzyh395vqfVEr88/uGlyyRY=
X-Gm-Gg: AR+sD10+C9K/PjyK3SYRZwsjE/XpCldZW1JZoInM/SfIz1OVgX1DHuXxnAqyaEiM3Vj
	/rij1gcnXQmwxXvFu7onHwLNLWzzd4u3I9CWuU3yqP+ACwp51j16Fl0XqCuxx4rjAIp2iQATE/P
	5uaPVJK3aihQX8GZpZjBwm9OL+CWt7T1tx4X10HGYuekCzPPJI0llgSkjAJrLtMheWlkLqRe6KS
	+6XW75y7UjO0x/aDRpgZ82zMpKbemGv0MAa9eezzYFtDqscJWT1Sf4+42alhVRcowFblJcE+4IY
	1GwQ4rnW7kV1YpVEGp+rauky41HKNT1nZBNZqjRHWYCp0FapcT37XSsv0+1iyfsMoC9m3j0afuq
	2fjYB2ufElh3ik+NHkY2vYCDEyryYCklpj7jAhWgxEVYX3LW73EBnqeBJdmak1jLAlmUcBXn8PY
	vls3WJ+wbOLsSSv51/Y2n6Jg3OWGoV9Wbf3aFhyO1Abwl3KpeZjG00ihS6Vox66UNz0ex/3RYy5
	gKz0wUk1+wA7WZ3T33zMsK8PQzPJqafFiyDuHxjKz8cdUnrqEW0nauePwhVK8lUUlvlNnoFwLU=
X-Received: by 2002:a17:90b:3bce:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-3933e5c8586mr32530273a91.10.1787033122544;
        Mon, 17 Aug 2026 23:05:22 -0700 (PDT)
Received: from [10.0.1.166] (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531fbb3c5sm7406599a91.9.2026.08.17.23.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:05:21 -0700 (PDT)
Message-ID: <49b4a00a-351b-4eae-8466-feadb1851156@gmail.com>
Date: Mon, 17 Aug 2026 23:05:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Dennis Tighe <dennis.tighe@gmail.com>
Subject: [PATCH] ntfs: validate usa_ofs before preserving the update sequence
 number
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

When ntfs_mft_record_alloc() reuses a free mft record it reads the old
update sequence number straight from the on-disk record:

     usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));

Here m points into the raw $MFT page-cache folio, which still holds
unvalidated, MST-protected bytes: the folio is read by a plain
iomap_read_folio() and neither post_read_mst_fixup() nor
ntfs_mft_record_check() has run on it (both work on private copies).
m->usa_ofs is therefore an untrusted u16, and a corrupted record can put
it past the end of the record so the two-byte read lands outside the
folio.  Reading such a record while creating a file gives, under KASAN:

   BUG: KASAN: use-after-free in ntfs_mft_record_alloc+...
   Read of size 2 at addr ...
    ntfs_mft_record_alloc -> __ntfs_create -> ntfs_create -> path_openat

Only preserve the old update sequence number when usa_ofs is even and in
range, mirroring the check ntfs_mft_record_check() already applies;
otherwise leave usn zero, which the existing restore below skips.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---

Reached by creating a file on a mounted image whose $MFT holds a
corrupted free record.  This seems like a fairly low-impact one, but 
given that
it fires KASAN, it felt worth submitting a patch for.

The KASAN error that I received on 7.1.7 is listed above. On a RW mount 
this is a
one-shot per image and only trips KASAN when the next page happens to be
poisoned.

A reproducer is available if you'd like (just reach out privately).

Found and fixed with AI assistance.

  fs/ntfs/mft.c | 12 +++++++++++-
  1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index fd20d7a..271a265 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2333,7 +2333,17 @@ int ntfs_mft_record_alloc(struct ntfs_volume 
*vol, const int mode,
           * wrong with the previous mft record.
           */
          seq_no = m->sequence_number;
-        usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
+        /*
+         * The mft record still holds unvalidated, MST-protected on-disk
+         * bytes, so m->usa_ofs is untrusted here.  Only preserve the old
+         * update sequence number if that offset is in bounds; otherwise
+         * leave usn zero so it is not restored below.
+         */
+        if (!(le16_to_cpu(m->usa_ofs) & 1) &&
+            le16_to_cpu(m->usa_ofs) + sizeof(usn) <= vol->mft_record_size)
+            usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
+        else
+            usn = 0;
          err = ntfs_mft_record_layout(vol, bit, m);
          if (unlikely(err)) {
              ntfs_error(vol->sb, "Failed to layout allocated mft record 
0x%llx.",
-- 
2.47.3


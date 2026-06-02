Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926B33C194
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369813; cv=pass; b=nPMwBe5CYrgyce8Ii5WrpDF4mU8TLLZU6c6glyzELzMxEq/v+2WHUo9oy8+1AHyKr+OTPaFwBwy/TRcH7YtrsRCo4lh5L7uiKpys8CJ67f5VVbaM/2BZay4zilRIc/LnY1ahBVe3jBqmzPQBL9EbMnJA1lAJMAjKELwrjp9Xo0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369813; c=relaxed/simple;
	bh=cwAVpJuKlEp9kEmPE4v3fWnLBXPmYqHqdhlp7l4T5cA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD8t7VWY0tTgyRreFd4lgWJvyxnjFWdG/2j9+QMtgAVanFzMpeFw7nIjZu4XxzLCQGH2/5V4JqeoBt37QnM8FVLU+HtcikTaRZb72dILt6KdHWmndFOq4cbP8yOP26HZm5eoyKhCVJewMwd9qCOtICaw8BsxygB3VFkx+s0WrVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=RFYG3QNq; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="RFYG3QNq"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e2fd65f968so18579827b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 20:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780369810; cv=none;
        d=google.com; s=arc-20240605;
        b=a8DJLtpLybl5K2omrbrLcRByBUbApRq95oMREysZuHMOMmYyzPOoKhwrnQbpg+T3c+
         lub9q/EX3slyJyrhmrI6kN6AezybE/z+Vv9b6Mn+AuOPts5WFLtNm0bWdf93v7iBgmZ1
         07vPeKYTNnM1Iccw6EkOMoCwiFGw7FmY1UfVoDtEmUCAHwGIQ5tYAhD+WdnZiregzHUS
         NCCslK8YBMg9hHgR9sIngaodkZCl+tWsJyd84wFCCLF7RaKCqDnae5YyraHryKardt+i
         dMDRUqnQlYkJpD+hcAREuXNuFUiftgSAsHmKzzh3YrJFYoOGr5J88up3avmmLNQO0rFQ
         E4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6fdhswAexcCHtqjvZiOVmNsqcqEhluDdYm31R2U+3Hw=;
        fh=ulEpty6juDdRfxm9laYOEevCXZWMrRZoUW+I2ewiAD4=;
        b=jfay8J7RKYNVojrGQhhYr6jQwdBvoS6ZWFSz46yMVDuBL2V1CjIp4LJvKVTanqlWw/
         PpfgwKJayHgzc93MFcNWKVIdB7F0yZswQkwAGXQayKdDxpo7Gt5sdZ1uMceEWYdycYd5
         saz1Q1Ct6eUe2l/QSngx40vkcj6lrT/qOg5XqiQOWkq0rHr2OXO/4AZM4Yx5WjDEY3ji
         kPs5Bn9NiE6gBh2Qwcv4aN+7jBnBEmCOZbqOaj/zJTjPg+tEzIQWSU/DJrdU1gXN2Set
         AontpbZsneVv76pw743+E9CmbbKJv1vXwHQ/o4/0ZHTJyR4p8mcXpEzXkOR8cYjLm1/L
         SFOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780369810; x=1780974610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6fdhswAexcCHtqjvZiOVmNsqcqEhluDdYm31R2U+3Hw=;
        b=RFYG3QNqrVMNsfKU+oEc8kLGG+wV2TD3Rfk0qUcFo/Bj+h7t/nspdx9CWFSHvQ0SqW
         L3WEqm1XaBfh/ppyJcGIeVRdMNe7nL6enu79d9bfw6Q9GZmLYyAvmEkkdFafJllCz+Nn
         5YxT//FU/osOlJGyH0Jh5svLHMxGw9YxwchHF6aZkH0APPIhVAn0D28bjuO/SJQz+87I
         DPjzN9hHmhuMOTO5d4Aornc9hwf1OYg0i9anAwg3SQbUdgq3a8876GShu2UYOAu0BIcy
         6pfgleTxIElHboQoypv3pcPUgwZpW809kuMkNtgZxVRoRmZmK8fLUmE1LHC7rAfT42fF
         QhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369810; x=1780974610;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fdhswAexcCHtqjvZiOVmNsqcqEhluDdYm31R2U+3Hw=;
        b=bOqUrn8paSuJtbFQK5yiLJzGwTs1TuNagk+OySJY/YApuCRaCTYHCuuK1oc4tLrGGr
         +kgmHphhUcMKsHQQ63sivRBFpaJwSuiBP00hhcznvBDc6yxp2INVUfINEUZrugwLjIkf
         pd6MLfP8I0bmJb2A3Ad6pGEYI7GuB3qucp4Htq0tbjeIB15tmoN476v66Xtn2r8TNhvG
         ChonU7aCz4zAtlOseZKq0StFr8y3fH7znnjcdAjpRVEG2rWrl3oTjZKoGsCv/CTzysDF
         cQ+AHA19VBW1HF4Y8J0pAifTRIj9F+Mz7hGfdzjeQwD/Nz1FUX1ULJ9EyWlDBHSg2rny
         y7dg==
X-Forwarded-Encrypted: i=1; AFNElJ8wlZljuuBCyH93QX2L7Mf8YakjL/6MqRq3fwkhDvGw40OvVQLHoYJuFGlDX4muerD7aZrOaC/jPL/PcrLc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6x/8a53Pr72EK+JQYYM3h6A3iTVR9JMGn15tBguHmoRtl5Cg
	VbZPfvYIfKoimp7rrtOv7/OoqG628/obWz0Ppq1gEhY77gAWx2ZbieN+eoLQM78n2g16YrXI1XM
	7Vluw1DHeL/pnii1hDSs0u1WtCqCGRdwQa1nRJPxwNu5NYs2GOXc=
X-Gm-Gg: Acq92OGBe/mou3pJTbwyKYboavqrZsxGtXNM8K+2J6cy+na54GMmeM4hpDSB3hAliLs
	YuA3yEg+XA+0AT9EIP8/P5GrcaVnN5kn+MyTU8w9BBcIoTpXVyN7s3eIegMLJb3NiKyVEzohHZ3
	giokvOZorhdVrsiUPg3F+R9LjaWPNlNh6eVL0lwjbf/YOte25Ks3QqpeN0EvR3Pd+0sA5URdaA4
	0ZLWgkzsQ4vH94AdmNSGdD7eeOvkoD3RO14rCC2NKNGZNJgiTdZE2Cuk7XezcK5MATiZIU6tZQE
	eDU224ZXQoH/coPDkiUf
X-Received: by 2002:a05:690c:3391:b0:7dc:1d92:180b with SMTP id
 00721157ae682-7e05c664b3bmr123328887b3.23.1780369809315; Mon, 01 Jun 2026
 20:10:09 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jun 2026 20:10:08 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jun 2026 20:10:08 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ah0wDkTgo3L1scql@infradead.org>
References: <ah0wDkTgo3L1scql@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Jun 2026 20:10:08 -0700
X-Gm-Features: AVHnY4Iui-ID622VDwxr8uEuQB7BFvNN3vwYOUNrp6RUN-4zlOIf1vlS7zDt85E
Message-ID: <CA+0ovChveuAwv=t15dr2m09E32bM48hHJxvfeEYZOhdNiEc9Tw@mail.gmail.com>
Subject: [PATCH v2] freevxfs: don't BUG() on unknown typed-extent type
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <christian@brauner.io>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

vxfs_bmap_typed() handles four typed-extent types and calls BUG() in
its default case, so an on-disk typed extent with any other type value
crashes the kernel. It is reachable from ioctl(FIBMAP) on a regular
file:

  kernel BUG at fs/freevxfs/vxfs_bmap.c:230!
  RIP: vxfs_bmap_typed fs/freevxfs/vxfs_bmap.c:230 [inline]
       vxfs_bmap1+0x128a/0x12d0 fs/freevxfs/vxfs_bmap.c:257

Replace the BUG() with WARN_ON_ONCE() and return 0 -- the value
vxfs_bmap_typed() already returns on failure (and from the DEV4 case
above); vxfs_getblk() maps 0 to -EIO, so the ioctl fails cleanly.

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
v2: tone down the changelog wording (Christoph Hellwig); code unchanged.

 fs/freevxfs/vxfs_bmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index e85222892038..1b8216eb1d90 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -227,7 +227,8 @@ vxfs_bmap_typed(struct inode *ip, long iblock)
 			return 0;
 		}
 		default:
-			BUG();
+			WARN_ON_ONCE(1);
+			return 0;
 		}
 	}

-- 
2.43.0

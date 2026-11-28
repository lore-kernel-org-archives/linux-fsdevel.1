Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874799;
	b=h9qWLclohS4VCeTkwqIYUZbE2iaTILxSIjMTeIUxvK3yDMDfEZSzM8fIe8FKMltVCSTO
	 +W4YGcYt82yckT1fi7lPyQKSbAbmHrGX5j4g1+0gQ94N/3YFEIPUrHm/ymloUz0YpZIdl
	 pk+Szw+pc/sa99qGtTbs5/Bdcxds5cQY3yRYmv3Z4R5C+TLINn9vXmUqgfC4H53Tql6ca
	 hyFDCfLRkVaLfk5L/E4wrRMrE1+0kweCjBGiJjdpveof8XtljyUd/yuxdEbLvvOTxkvra
	 ETfrDHKlhwcIihWpS4/gTQJyhrcpGILITkVQnJXQ+Bsq1sbjnTaLF3CdWAjVrPCLiWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kNbT+zjxASw3wxSoXIcEpE9FcJ74Cmx170fazyS3CUA=;
	b=KB4KMDe7m3Wg3yrOywao//+0deqDe00uanbHFl6PuBECYeuXH9g4K2N8UFronG3LsBw9
	 Yiw6p4JYFuEgQ0ESrFro4avn1rMRDR9TABDwLOYXPRWLGFJ+o24Aqk/gLjt+Txin+Ly/w
	 cz01T1VO+HSjLGswY77+7Q33iwFy++qkS8INcyXjE66+R4OXvoyV8Ebo7LcjlBfuxBGTK
	 T0RvO0/tCJMgG87mFZL1SC4XNeeKihxPZwctATxSV2cOAsyGs86w5xXa+hkvD4U95fqH2
	 GGrSRl2rZb/XiV17Hv2T1aD4Xp9zQhCNajrT2vFatobnO0dLtZKvSz6fVX1UfmptETw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AzqXoagq;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84E606A324
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 14:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E84E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AzqXoagq
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94958650b09so855124285a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874798; x=1796479598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNbT+zjxASw3wxSoXIcEpE9FcJ74Cmx170fazyS3CUA=;
        b=AzqXoagqf1kGZd26duBK/SD2F3C9ge/EaCa9HZv+UHmJws7ASCbLp2ohWSPXLQ+Z2m
         nCvaJAbOkV994bA9cotqxypk+6d8G1eVvbHy06G8Ettpmcm9c5VwCbTaK6ojjX0aSYbQ
         PcVUUDgCRsEDNmXvAXdEXqio1xq0ZX1W4FUecNwUkoHXFLYSalSqzH1tzJ+7G0mErQKd
         MmGkxb4mLjytf46DnRLuEaV0+Ds6wF4LGjRMnBSmFe8fJKLYZ9XHAds/HVjWPwM9bSDO
         gJ4HDIydnV6eJQby97NZ6lcxFC0HcssDH8prCpr8vYxfJ3Z28WuB9SKHR5EHioQvS5Lt
         ZseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874798; x=1796479598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNbT+zjxASw3wxSoXIcEpE9FcJ74Cmx170fazyS3CUA=;
        b=u3Ra0965CJ3g5NB/hoSJCGLiUrzduudymIX7x6WersJIhpP7arvom1sWktqZESj7dT
         MMnZHQvS48I4/QbL30lUHWwyBLWOUiHbPnslHjni2y/GML45hpwO6vWwLnxONzb9c+FY
         64b9KlOh3QBhmZTMuIwviO2xRA7W4xb8w6RysKkB7hvqAQtvCyLVdV/9oKYQavqfSh7t
         IEX10hJMMIJBQ/QlfHvWPP3amXEI/P/Hk3ScRzcYhnjDGj/bva6/0bm2DlmpAKJ4M4sm
         S21rlPnmOMfY/fr/ESAgDOy0HBvTHBy7hhsTyVIS21eJCF/DES1Kd+Kd+B1Sxto4UKBa
         sdzA==
X-Gm-Message-State: APuU4Z+8yOo1nP5j7cSO63gLaf7WKSQpw0z/YC78LyXNw9Wx3RZvuFvD
	UxZ5IeYNv7tJ4TNCpOxw7uvPsBqBfDGGMrW62RY+nJ0YVnchvUOPZTUS
X-Gm-Gg: AZFdTZfovhI/L+zY+/nzVmocntkxyOhciByPqViqpH5jZRCOVrw4mZlCGaJRbbXZXw6
	lw+siqOQxW472uS3hbJy9zxdfLsLMBMjdFOurkolSGR0DTeGcjzEozLc6mMA4Rxjc3PYrg9EkZc
	svHnNJ614pZQEtSX5OdoaA9p/WT9fIp3MomfL01c7/L25OHsAfNUzoL9FBiVBxhG5KC5rp/RtRZ
	zskLYVz93tvLiAoQ9G0/HHxeare3UtD/Jg1fPBKQgcWVoO4mmzNO3qKSB9NGzisuPhNK8+T4zAB
	nswmiBd8jzcVOtHRBPQWH5xvD6II0tjjzypny2igWZLCLJdcSch92HMINUyc1WPogL3A/xcVsGK
	dI/u4iljmukGfG1y2jupX4zEJeUhXNmWxwdE314Ob1F+03TL5NL4kSvsyThmARbqtvCxSxH1j4h
	MSUFElzX8EAaV1Asn3NvGK9E91c1VOEcdhgv1UyNhTdev5zweQosfmSqxQrD56dFa0LFmu29qAo
	b1LR+d3j8CDfK4sW9Mh7FScltUfT9/CeTyDllCY+07/Bjyrjwufahjmsc5H2akJ/azA1C8Qz9CC
	R++bFRpNiQ7A+DcIG+7HhmoKtFsJTJ6+W+a+g67coTUY9OxKzWXYrygTS7mLnFEOnVpHWOGKmMK
	XiwyJ
X-Received: by 2002:a05:620a:8386:b0:945:d22a:e82 with SMTP id af79cd13be357-949ba96e395mr5213510385a.27.1795874798442;
        Sat, 28 Nov 2026 06:06:38 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949c555faf9sm1975055585a.0.2026.11.28.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:38 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH] nsfs: fix the ns_id_req kernel-doc prose
Date: Sat, 28 Nov 2026 17:06:35 +0300
Message-ID: <20261128140636.41-1-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The paragraphs describing struct ns_id_req were copied from struct
mnt_id_req: they mention statns(2), which does not exist, and a @param
member that struct ns_id_req does not have, and they describe the
listns(2) cursor as a mount ID although listns() lists namespace IDs.

The member descriptions were fixed earlier; describe the cursor that
actually exists.

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 include/uapi/linux/nsfs.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index e5909266ec3f..0e7013d20d1f 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -97,16 +97,13 @@ enum ns_type {
  * struct ns_id_req - namespace ID request structure
  * @size: size of this structure
  * @spare: reserved for future use
- * @ns_id: last namespace ID
- * @ns_type: bit mask of namespace types to include
+ * @ns_id: last listed namespace ID (or 0 to start at the beginning)
+ * @ns_type: bit mask of enum ns_type values to include (or 0 for all)
  * @spare2: reserved for future use
- * @user_ns_id: filter on this user namespace ID (or 0)
+ * @user_ns_id: owning user namespace ID to filter on (or 0 for all, or
+ *              LISTNS_CURRENT_USER for the caller's user namespace)
  *
- * Structure for passing namespace ID and miscellaneous parameters to
- * statns(2) and listns(2).
- *
- * For statns(2) @param represents the request mask.
- * For listns(2) @param represents the last listed mount id (or zero).
+ * Structure for passing parameters to listns(2).
  */
 struct ns_id_req {
 	__u32 size;
-- 
2.43.0


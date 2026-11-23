Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402824;
	b=ULx32QWPdIIGs5AcHF1Q0a9Q5qD9S20knkQFryjH6OPM9ptvdwpqQDWpoVVTklaL0t/S
	 1CdldSaPj3z5H06iBaYJBYXXhNzpucOb9eLtBreovgDiKsh8RWMcUis+9aZvQsCMKCm2C
	 ZlOsKAKY7Auv3PX97E/PpY73YECRgByP0yCDJ/dqDHIyYWH7Cj+BTHbT5JmYTKg/uQ1pl
	 ON8q3lbskvWybrp1m4uV52/KcJAM9FYQ7Ps8q0APWR2GNp5i4dzyEIsHLeLGCtp0rOBwi
	 IZyhrjllZHFfaNZgBtUBNzo67twYANglDHfYeD6jT8WDGqHAMeIuUE1S2YP3KoKnUvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+FgxJSlCMhr6jcW4y/MvZaUC1tSRD2CiwZ7Xb0DzK+s=;
	b=OlBLb+0ZDoeaqsBsSTP66gMcAsfXRcP3RDtiGi1KNLJDW0W61lRuOFp9gjiQLb5r9Jl8
	 UdI2pdqtzVA52Db+KoYYakwCj3Va5GkuXeEEhP2wNXbXoQFLghBnhbUl6qeZ9qXgoDXWD
	 G5pYWKs9R/zXBOxkhY9mv0WlMVKNRQEWTIVyiYzOuvSYo+Ry3QWoahyxNyF7VF03+OYdX
	 Y4PPU5H7/stLK2OYl1uJ65SHS42eGp+JeAfRgO75uUW5DVzaldvLAx7Dsssd0U2SarzLY
	 Qr4Cra3TAJDWrVguODqi+7pqdUsXp3JWfOTt70EBP+T0IG7WcVqBGwSkswdrmGDrE2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cn/8pBu3";
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB962606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 03:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB962606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cn/8pBu3
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ea993271f2so12228985ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 19:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795402823; x=1796007623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+FgxJSlCMhr6jcW4y/MvZaUC1tSRD2CiwZ7Xb0DzK+s=;
        b=Cn/8pBu3pDIeFt8N15hUWOPvoG7TbKXfgpsTAn47Y2l/zwIyq+2z+kbkma8yPW/4ah
         4u9MuAo6vM+i5vmLy+43Wo4sPw89W6R+BeaEtdGpf0pyUSE+XP9lIHStApSeuQqbpBG3
         7hrMsr81GrTEtA/pU8w8vc+0ExsdDtUUaOzQtZPXkXCeu5E2Fl/1M23N6WySO56Tdh4W
         1NE/CXKFV4BKY52PcUxRFVCGgb8KsXrGz1bJTrwpg8J9nkvapYzl7iuZ6qkVkW1ZhHT5
         pFWwx7ykDfsj+A7mhgiVNOikPoKnheVCQiFkTagf5IZmueeDcBN0moQkBOfYDBNLGHDQ
         9sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795402823; x=1796007623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+FgxJSlCMhr6jcW4y/MvZaUC1tSRD2CiwZ7Xb0DzK+s=;
        b=qqw79p34Xgb32I0jdaNtKIMTXUXWnBWf0f8dG3uwV0+GRu0cytZRICP1ebzwCFxNqr
         EFuHFl2075/8ygwvI12HRA+iLzYZ2mvyd4/bFVCBNG080Xy29QstwiEQUsiqh6RV70fB
         gTzbjaN3+pwT6skaDrnZaN93EoPaMCv/GPGZ3d8KJ4Knw9+VjrYC8v0aQCJzH7JB/6fq
         TazS2z5KbST3JeX0SyrIYqrvivLUfiokrh7X/SIYRKZXZCRtPZsgIgW3H5fHkK5LHVOU
         5fSLsfcjioCj7LR/b77knmZCczy5tAKZ9Hi7YRqCVZ2BWmjk7l7jewVgODrTo8/M02gG
         3V8A==
X-Gm-Message-State: APuU4Z8Zq2QaMzEGQ7HO7IqTk/Lg36+RcckcY81MY/yBzQ1fXRcHgBCR
	N9v1w3Jz9QQuDIJU+S8RoTvVVkAeK5WIgfaTPgmFKL7fizVNrCcEW77WGG0c51wAbBHeYg==
X-Gm-Gg: AZFdTZcyaBs3hh3+KbSzfhFocM3BJTk+pKfnuCuwG7Og4NtZhO/l+Z3Z/SqNMrC+UCH
	+89y/7N5n6BW/0bcWo2ibAvc4SLOXiziyeLGri0GMSs9eyxFifLCo0pOQYwDHQkTmGreOf71YS2
	dOx69kC2/sLctWliAaCRAOyAKIOlVJ4Kk1gxXR7bXXE+CRBSb33T0Xxm0WPMU4APruP0MGEIX19
	h5tUnNe7i0WxCMnG3e6wi9TT6upJ3eu8MT5O1KRaMafKgZSsnQMyl6S4GZFanFgGU8ixtvf8JRF
	zjHdk0k1Nudu5/bpwfliYXj+l+rON0dWKcT4/WAjSew5AlKCpRskSjkGP38Gz1Fmme9i/6+0+dm
	Ih2u4tTxDAGmQ62MvzuKR/eWw1LvzHaR//YKHm2PWGifyFYErsygIMJw65iM0XfFsejHaeo5N9A
	dFLiieDK0UdvZ4wx8AOMPZc5hVRdvt4maQK7igmks+dyHwJRXBNGDybvPTM5Kv2KxaJuCdkwXGd
	R4dai9m7dsOGsK7hM8X0eqjSdxlXMrgpqdmRGoM7NWA1d649xKQVJnTxB+bA9pvuzSISpb+w0Ew
	H3y3wRXUgYbiAI7rxeEGzjyGQSn/Kzd8spJ4D4ELxu7cJsc+fVx6Xpj8rSKLsUkjJ4F8qNoXIKA
	=
X-Received: by 2002:a17:902:f603:b0:2e9:6788:9381 with SMTP id d9443c01a7336-2f03f0c1f04mr95101065ad.7.1795402823169;
        Sun, 22 Nov 2026 19:00:23 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f070a12491sm21615055ad.8.2026.11.22.19.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:00:22 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
Date: Mon, 23 Nov 2026 11:00:14 +0800
Message-ID: <20261123030014.3116755-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

filemap_cachestat() treats every xarray value entry as a workingset
shadow.  On DAX mappings, value entries are DAX exceptional entries:
same value bit, different bit layout (flags in the low bits, pfn
above).  Decoded as a shadow, a DAX entry yields a bogus node id;
NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
dereferences it:

  Oops: general protection fault
  RIP: 0010:lru_gen_test_recent+0xde/0x300
  Call Trace:
   workingset_test_recent
   filemap_cachestat
   __x64_sys_cachestat

Any writable file on a DAX mount triggers this once an mmap write
fault has populated entries.

DAX entries track present pages, not evicted folios.  Count them as
cached and skip the workingset decode, mirroring the dax_mapping()
split in the invalidation paths in mm/truncate.c.  PMD-order entries
are counted as one page, as value entries carry no order information.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 mm/filemap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index a1b2ca5b933c..caad0adde792 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4694,6 +4694,16 @@ static void filemap_cachestat(struct address_space *mapping,
 			void *shadow = (void *)folio;
 			bool workingset; /* not used */
 
+			/*
+			 * DAX exceptional entries track present pages, not
+			 * evicted folios.  They must not be decoded as
+			 * workingset shadows.
+			 */
+			if (dax_mapping(mapping)) {
+				cs->nr_cache += nr_pages;
+				goto resched;
+			}
+
 			cs->nr_evicted += nr_pages;
 
 #ifdef CONFIG_SWAP /* implies CONFIG_MMU */
-- 
2.53.0


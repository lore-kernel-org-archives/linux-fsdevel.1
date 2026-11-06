Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969175;
	b=MBNtBJhP9HHSkOlc1XHtZvYtUn7LHlsah70cMUa9cTO90RWqjDBCTo7uOhYEOJ+y4Fxg
	 fPryHalVOAeC1JrqP0dqDX0SI1zbXZfm+tiuCzXPpPwGzye07RItQTTN/WW+WqBcE3vOq
	 FvLp+6varrnppL7lzTOP9QilIKPY96iLbDdn7Hmzft/58V6mn8U365bmnXcWqJmU75MkX
	 mG07MrZ+8vjHhSVmIb4YEj/STHlboBK5Z/tMcwtiKizDgxXk8bqmRmP16G03DmfV9elHf
	 aMIdrq7OQBVL9KtzWUoDTzgeX8IZ8OmQ24T9YAm0Yu+NeOslSU8vmz6s9+kyqCwcHjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=to5ZYe36a7Xl7ja/Fvmb8moZkHvXAEhFxAyr4iAV0io=;
	b=SqQZlorPs3snspSk1sqqieokOr/j+fUUmraBWubd4h2gTDBP35GFdp6ZfRWZWatv+h/d
	 DQUi4QWOvn/bTBAbNYmV51J4CYZ+dPSe+5RXS1E+To1mR70Hrm7mTNmRHmDRZ3sM6xYIA
	 ImYiBjc4s+FYNSkj7oEGirQgGF4Bm/PKOihGyHHuTqNO/SI/PYJD4MFKLKt+721ArRuOC
	 c0Mo3MeOH+TbrMelDkkmtXcvEirA9NEr91xEYtpzUBiYoLoddxOAyRYrlWAKe9gkANJBc
	 4oY7fULwJersh/tAsaxE9aCxAtOlmUIOGNn7NvKNYiasUQwyVF0ntM5P+VehMxT64lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OtI1fWwO;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D531606D823
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D531606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OtI1fWwO
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36f8cdd30beso496778eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969173; x=1794573973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=to5ZYe36a7Xl7ja/Fvmb8moZkHvXAEhFxAyr4iAV0io=;
        b=OtI1fWwOBO1UK/xBVF361zKX5pNVC4vlOBT8ozO8B7jwOHG6ejWk0PFQSiaUO6goh1
         lqLolKuP/ZuEkvIasGgWRMlSwGUPYOU2TU7EAJBPDqdrcmOlq6Gv/y/kjwPBFsoMk+8g
         HLztc8XnbL13xQXeFLXuyOuZZ5+5QTP0FgLCdYiULs/twiNDdBYStOmozF7hKRfh+PhI
         pChKKxj9DXmURGSQHP92wwb7befLbFwo6kZn7sfpYZ7RGTmsMd9807/pXqyYsbZskAzG
         GpLDAKkvHnHuHMAStFBet+Rz5WhPr2n+9S1T1PRdarZ/DSu3iqlO8geZpC5DtSEVHydB
         xitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969173; x=1794573973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=to5ZYe36a7Xl7ja/Fvmb8moZkHvXAEhFxAyr4iAV0io=;
        b=LT5SdLS4yn+taD3zCYLARC8JY+8sp0fPZgQAIii9ih8bizmfqSuxfqBmPXMeAN9UFc
         UZOR3MjEJeqhbPM6x5SXTaG85GfM2E/9afOFarT7d3ZDN0UKe8TiiHJjiPwVtYoa/pSC
         /4ln2CqIqbtP+yxRwXxjGhZDWuqrbkNdckHZSxAAvmdbKgKrLIVTrnIQRQZedpQbbs9B
         u4wW92zm0IopDhK6IfGj1w5z4z0c9IvocQwBDR+W8F/SRDFS4w1e4KQQH8fd5ppFP3lx
         3j888eV8fkYukFtwobeXgmUXhPOztLzEJN5VY8srsDzjfZmmdGkdZK8KBjBh/EVl2TJz
         xOiw==
X-Forwarded-Encrypted: i=1; AL+hErGDgZfXRws3J01NqKQ2xTJY3U6I8+r1ZS4A/FoO1H7G8ZQbjtNUl0nfjzEeXsTjZnKyvH624rRpPZrrPYUk@vger.kernel.org
X-Gm-Message-State: APuU4Z8+HwsbKLUisSQfpdtlnQQZd6G58JIQSwBxIbOsNG7XWuhsfXyU
	6H+Ml17VgETwfTmCa7k7GNsJICXSlMR814DnZWyc+jYwgkru1eJMNyms
X-Gm-Gg: AYBFou1JmKyPoGG9A38EhkNSGqc4jj9y+8cK0JAYJpzDOvDlkls0m2llSEZTLBiYF9H
	feNvQDNzqgJgFRD5bdMCyCaPTyFykwtkMx9DfunH3osjOSkqwyzLT1FY+/9LCBgvohzIFhvTeD9
	LbsZ4jGmhbKy4+IMDdTJZ8ea3oMa+05Wi+gqyvLaEVLBP3hsrwhUNa0RN070pa5DHYu6roQgGfT
	57YLkqIJIq+t/T2LtDhRWx3+gbcKS77luq8vxrmLyEMmbXsW40PjaoCYK5O/1huTjbABXj86utO
	ci9kPZTO+xp7j/yK09zQV2cyJGsx/HxtY2sVvGq3zlQLw2OcLp0hItOV4jzoAEgSCsITAQDJVvA
	e4aUifY78vQ75HHgykaQBBD743cugCV44/XpVPA2JHPTaeTCf91BLkkriZ4BG4OWiUI1p1HVaDt
	6hQRGbHlDe63X/cAizsZJAeENRJ8+j/amjLonm1HJV3VG82O0Zf9nVff655JCbBlooYHXdwYNCa
	dvsy15byvstkf8HIOX8USgWee5yi4lSD16GcpjVa5pJZ7u2hPEZg4ecPvZjPgf41GyfqQpZ0fwY
	PDtVOm/oWw1OM88tQusWZVd/9nbjo/niHOo+8LGVWlHT6rI14jixXYEEYy6/97OYdg==
X-Received: by 2002:a05:7301:424a:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-36f772f9061mr3192845eec.30.1793969172763;
        Fri, 06 Nov 2026 04:46:12 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm6802331eec.1.2026.11.06.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:46:12 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] ntfs: do not convert a named $DATA stream when making room in a record
Date: Fri,  6 Nov 2026 18:15:53 +0530
Message-ID: <20261106124553.2617026-4-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106124553.2617026-1-wahidzk0091@gmail.com>
References: <20261106124553.2617026-1-wahidzk0091@gmail.com>
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

When an attribute has to grow and the mft record is full,
ntfs_resident_attr_resize() walks the other resident attributes and
converts them to non-resident ones. For $DATA it always opens the
unnamed data inode of the base inode, even if the attribute found is a
named stream:

  tvi = ntfs_iget(sb, base_ni->mft_no);
  ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);

value_len is the length of the stream, so it does not match the
attribute that ntfs_attr_make_non_resident() looks up for the unnamed
inode, and the WARN_ON() on entry fires:

  WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
   ntfs_resident_attr_resize
   ntfs_attr_expand_locked
   ntfs_expand_for_write
   ntfs_file_write_iter
   vfs_write

With debug output the values were attr_size 13 (unnamed $DATA) and
data_size 550 (named stream) for the same mft record.

It does not need a damaged volume. A file with an alternate data stream
whose record has no room left is enough. The fuzzer found it through a
single changed byte in a file name of an image from mkntfs, which made
a write grow a resident attribute in such a record.

Opening the stream by name instead would convert it with only the mft
record lock held. Its folio would be locked under that lock, while the
read path takes the folio lock first and the mft record lock inside
ntfs_read_iomap_begin_resident(). Streams are not converted from this
loop, which only tries to make room, so skip them.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/attrib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524..800e53df5 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4932,6 +4932,12 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 			continue;
 		if (a->type == AT_DATA && !value_len)
 			continue;
+		/*
+		 * Named streams have inodes of their own and are not converted
+		 * from here.
+		 */
+		if (a->type == AT_DATA && a->name_length)
+			continue;
 
 		if (a->type == AT_DATA)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
-- 
2.53.0


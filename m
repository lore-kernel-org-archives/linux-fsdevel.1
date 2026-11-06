Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956491;
	b=u7nTIt5N8wTDxRJPZKqL1WohoCP5UOyUa2503ZHfc7rS+x9V4thlMdt4tk5XOPUY+xpo
	 E8ky0Rjm2G9LBfKbpqFCaAjQwd5YEOLj9xzAPhT98lLYv1tdnGV43FGcZpmnAFTlhfVZA
	 GmR1JKe60MPBbm6QzxUrmesu+c+rzkrxnKE6KfH9EIwEAdQFQj3N8tVA+EI5al3UKmxu/
	 V2zsZDsEya8hWpMNgsKeCp2mW+o+9fJrBG8299FmDioiD4w5RQQnj5vtnGcbrSEVHPNuq
	 5Beu8hVZ3sdD9kwY9wfu5gqh4HMbFX57akIXN2/ZzR7tarb7cNYYH0U2x/ENyXppuTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cc6pG2na6zv7wFv5oObixxN/7ExlBCLIUKtBmr4Nunk=;
	b=WFJOOz4xFWqF6BzDxrY2BRJm2tHZ08VvQZfOmFm90lxTr8qDsDTrAdar+pimNJFW6KeV
	 X6UZMBl9N8X0vZ+xXQBDZBudgj/ksqBKaT9keN/KPooUfGPTfnTH3ZJiKsa54+FoiY3CN
	 z6a5G9odkzkxzbwC1gogyFitztpW8n7WU/kpTLVoQ1wJV8wRPb3pRbqLeBMD45w9KWn5o
	 L277Q8f43TbxkybUrqjlG5CAUQyB7V4weuQDAi2jHMLYEj7NW6fqfCTOFW3iY/27zCSQ+
	 BLD2kTexIPrk6dHbU7h8bYbdBznp7299sK0QMnpNkg4H/TzoU/3gyKhkVE7LUkgko4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cK2Spu0+;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44C606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B44C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cK2Spu0+
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1931ff67a29so1451317c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956490; x=1794561290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc6pG2na6zv7wFv5oObixxN/7ExlBCLIUKtBmr4Nunk=;
        b=cK2Spu0+QMhHtZ1j9s0GKtYiutcTB/1jjUoYJ1YkyfWyP86UhBSo8LggtmCY7+eRdc
         uUPcVBOs+kGKBn2W0hlhYug+AyRqx3MLCWOQ8xJAjiwO2M/NFMSxe5MBP3k4PcSkmT6k
         VY8REk7K6wOs3KOrasIePXOuzwr4StLGxS3vKYyiGr0b3ig7ueHWu9Ha6kSlHbuLuOoL
         QKRKJIFV6X5PPFWFzAHtJg6br2IhsEAib/pEgFnxX0LDV5MY/zzNFzvuxh8hEBe6HIgS
         d5n9RT8+F9UKVzT4acg/C6JEd6Yfh+uA6bRb8A7gFvqIXiBSKwkxCJRy8SA3ahDbuhxo
         fMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956490; x=1794561290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cc6pG2na6zv7wFv5oObixxN/7ExlBCLIUKtBmr4Nunk=;
        b=ZXfEXmjmMBLou3Jb9q0Pk5+hznbuLAbJ6CTnPVrok/oqswRuNHdqPAwWhlRGOAMOmD
         4g7HCGWHQ0AYMdnq2ZMm+vMkJ4SZeWlLRJna6EbgwhdGWa7hKFLwRwh+VuQ5x8a898IM
         GRR/9Ebp/npKLWomT9p0WQH9DFfRITGPC8i1La8MTsZfFIhnBC29JtVUQxQ0j5maMw+e
         NTa1tRMvTH06ioVBXJpTsefMUd3PPQlOiARJ1KdX7yvPI6qyFFAn/feka8epX+dF7yt8
         BlCvqKirueI8wbo2+r5WUB1g+b2SIdd3br1jcbJ/A+WcD6mxrrrioeuhf0tx8CkF+7mt
         WQyA==
X-Forwarded-Encrypted: i=1; AKwUvByjY9L4ip0Evqsd+Gg1sxpFppIfoIujhwHtR3shIpRCBJXIAAQTFotJnweXLO7gCRGZaT+x8JNbKTkb3ViU@vger.kernel.org
X-Gm-Message-State: APuU4Z8ajUMdXnksIGcaQLQ0gnfJK8GEaE3pjjHD49A0NGnL2u03b4w9
	X0rwPRo3QddZ8LlCIyIXm/Edb2cknAiO3jeFovDE/pxLAInV1T6UubEk
X-Gm-Gg: AYBFou2eSu6wE6eRKofMRLYGOjTGYAVFzMaKW2bz5Qgg2egFrLKR8JnjfS+SHxtl0Ol
	Sugn7LIvL8VTUrCUvW7TgxKkRj1iDrl9kmPXKjA8bt1x4QbHKMfFqgDYyu2u3AAm1D3adTFc3Kv
	XPLi/d3WjZXRzhyZQZkbg/zO9FfcOh++DmLfh8PfIXwIvNdrzDa1lb2VZ09KHB5xfKFPqjqz440
	5/WeE90ueCVdKWQIk9IHvLSGDYE8ogHjTsi+vEnAgDwHqT2FVggaZW6eA1XhqbXxZ8XZNfOfrSx
	Yp4ySq4J8fq4vs5M34N0ZjnAninW4CWk2q2Zdad/C4c8KIP+otjXYrhWIC3rAu6+RvTAi32haJH
	bVc11H7UEYggZXGyySIPbks6Ulrb/2M3ageiYJJHPGqbFsWllT1ZPEk//oYr2+ROaWu/7ahiBBu
	RzTL8ak9cm86q/2JHaTjBEwEqcamCGNojcByPkFimBSytB6cUN3bbX2dPwEKpMBOdAadqPszeRF
	UraULCeCyhkvntHc4O1VLvzBoGzXBI86yOihilqPwoo/+oLEUAMTl9DmvHCI45ejJp0ZPHjAq0D
	w5uU2X+gwQGPUZeQ5F0/hSUbMRes9yTDCxcR1aqZyGlla5d2xC6o+hsF32CxVqbJtQ==
X-Received: by 2002:a05:7022:288:b0:1a6:7a2:cfc3 with SMTP id a92af1059eb24-1b25d30ada5mr2387351c88.13.1793956490207;
        Fri, 06 Nov 2026 01:14:50 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4200968c88.7.2026.11.06.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:14:49 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ntfs: open a named $DATA stream by name when making room in a record
Date: Fri,  6 Nov 2026 14:44:20 +0530
Message-ID: <20261106091420.2461683-4-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106091420.2461683-1-wahidzk0091@gmail.com>
References: <20261106091420.2461683-1-wahidzk0091@gmail.com>
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

Use the unnamed inode only for the unnamed $DATA attribute and open any
other attribute, including a named $DATA, by type and name.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index fce7144d7..0ff671e9d 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4930,7 +4930,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
+		if (a->type == AT_DATA && !a->name_length)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
 		else
 			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
-- 
2.53.0


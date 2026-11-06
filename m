Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969167;
	b=vHdqAiQmCGTKEeM/a049Jm3QIGRnV01ltWUtPXj93LQ/fKKglgY3SrSbvl/jnx2xMhbj
	 7XNBeSo6/nCYEihkzuh4AF+7YNUkYkaIg1OoJ7BUxS+WVxO7p8ACVgDe1rayNH6UlkSAC
	 d4JIf2PmK5batU4XGJTu9ylFdg2wzrTKXaBSBAdXvEOy8FOswjnrGIeT7Az43ybgsK2Zp
	 iMAcWQ6i7PfVkotxQvAjSS0NtmxKN2kAUizKP18m4WyUcvglKqbLafQAwwfjD5CKdfhEj
	 rwM7lNVLYQnFy4FQbWl/lxwQuSo/vQnstJBCncKMl6Eb3UzRDZ4gWDK6VrgofWBwZ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
	b=gNaIoClWwgTfN6av2MLzHQ3xzHG2YH39sfSiubfDeDyqOXtGVcHZq5RJkXAzVO/6wyf5
	 bUF8oQrttx9zM6lBa1ZO5smZH2yTt/Sk63I8J3qCVDrLWjYpllC9yvJmrKRN7TuPUOml2
	 pigMd6a8oxj0e69GPJ0C15lff5HapmA95cor6F+dQZFATY6ObJWmvEZdw55sJ1sDmEW9l
	 4M8YXLpje9b0mHNiUPyILyJZPD0BAgTAm4AOVTWUjKgD4BamBNYYFHJ4L6VtxQNz4kJMW
	 tlcZtvpMopxRbIhocZjSmLf96POeMuzPDpj82IxD2Q4HU8nPAUEKqPhi1Wf8Q07simA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKMrIy2t;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB0606D801
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BB0606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKMrIy2t
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37071c0f42aso173860eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969167; x=1794573967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=ZKMrIy2tc7o01+01zW+B6xXvNtwD1DjIQVLY++gLeXaXPOpnhp7nOsCBvxXiWojgv+
         3HJmPEJpyHZARyLx+czkHayTQEvNs6rWHsm5SnG2M+t+2v0HEhp73a+71EOUB9EGSuR6
         NmffL8RA+Wy9xrdBvjdecpWgYBSsD/ahJ79dsS3a35olzO5mvoPjx5VThkn4IU3x17hQ
         1Xl0r9INRI6M7qYJ9UFfR5jyGgggFADXIHOnpRCuU0T29LGF3M7hq/L2+wguPA0HvqIt
         hVemwfnh9vy+XRjDaHkj6vXjSQpRC1W+eaSCmDkU3dcwf2Q+iq4/c0U75rPQQye7Yf52
         +Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969167; x=1794573967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=Ul4+tnz9AVfE0bkQU/k3TXtFObAnT7I6V61B9XwFi/S9FMMexQBuxuWJjQ9fhxEzrF
         UaDcNMeeeVL46z5QrqS2UcvuZQuhT/f6LAfNFfQVikTf9vwU7134OWYR0/oitcLkpEgI
         8ykeY+J2IVpZLpV9dukEJsro+RY1heZ9rcR4y+ew1ObdlOfAb7vhZrP7//DPdmEEkSl8
         hjaZOjGjW0/4xEYwIlcQ8DvqaY8WgBNUj5N8iakwOHNgbKbTyE2lU8hsvnSKnaW1oNHb
         VDp+f8n159lLAuK8yGXygoOoLcz/5vFLU5c8jXcWv7jvpUOscEe1Kx6L9HxullzTt1u+
         7rYQ==
X-Forwarded-Encrypted: i=1; AL+hErHCyMH8vpwPM7ohGJtgycGow65O6vRsURObsSImb8eB5lHEDsD5BNCxqO7HO5wbpLf5Kmr6R9HYTzmNK3ch@vger.kernel.org
X-Gm-Message-State: APuU4Z9/hTcHHmILibmrjwvvB+JY01s2pix+9OIOcnwG0JdbT06PSS5F
	xODPw9qz6mIkfcZWrnj+1FgDulwHIkW19uf7a0JGjVTZ6tpCPso7cXC2
X-Gm-Gg: AYBFou29kMm3b1L+shm+z/Mw7XI5e4h0nHh+6dZurIv2JzBJOiBs68lWjzl/DMVJkNn
	n5TufkASUl7cQFwmQWSkvQIG9jMbsdRdd7cI8k7QdjUKrkWEKnyin7JYo+FZUUhcQtLNpikjTB0
	IE/A0TRusZKJFxlB/7QArh4X7vxtWqDybAFKWl3zvUww05YbpuK59kAPDjfDBjVjnHlixator3b
	Waf1RZ4gqlqsQY3LX1SotDzpMdWvE07qgFzwGu07y9GGjwFe28vzRpzjXA3pGq2uRbZaUpmxJ3Z
	tbYvZub7AbVLD6P6f4ZVnjTYVTpZlN3b0WqW6ygsr6L9AydCXyDESjNyFRMrK2QI4du1uvUMiyB
	f+EnNJ2I2UqtWJPxXLsPi2PtuGle99n18yY8vYz4CJ5bg8SNjrM1POH1XfUBY+m0+fTM3Tro33z
	6irvCk/YtGZzdbphRkKwDfPX4Jqk6MqGIxufasaoQDljJkvcVp3wEZcKyC1uy8bZIec5zTVjILB
	xwNU99nbeH6+BxYUBZ0xspdWWEje3eeyAnVwz0/LFQcxg3ipDKNFDZibGH6m42AZR/lITP0fUAf
	SGxia+OQaAnC4NaHGdlcD6lslbSZGJe4QkXoztGQfASoouZS9ZSgvlsmjpzfu9Kb9Q==
X-Received: by 2002:a05:7301:9a81:b0:369:38e3:5363 with SMTP id 5a478bee46e88-36f7494cfb5mr3376030eec.7.1793969166328;
        Fri, 06 Nov 2026 04:46:06 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm6802331eec.1.2026.11.06.04.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:46:05 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] ntfs: do not read an index block outside $INDEX_ALLOCATION
Date: Fri,  6 Nov 2026 18:15:51 +0530
Message-ID: <20261106124553.2617026-2-wahidzk0091@gmail.com>
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

A directory whose $INDEX_ROOT has a child node but whose
$INDEX_ALLOCATION is missing or damaged gets an empty index inode from
ntfs_read_locked_index_inode(): size 0 and not non-resident.
ntfs_lookup_inode_by_name() still follows the child node and reads a
folio from that inode while it holds the mft record lock of the
directory.

Since the resident iomap read started to take base_ni->mrec_lock, that
read waits for a lock the caller already holds:

  INFO: task init:1 is blocked on a mutex likely owned by task init:1.
   __mutex_lock
   __ntfs_read_iomap_begin
   ntfs_read_iomap_next
   iomap_read_folio
   ntfs_read_folio
   ntfs_lookup_inode_by_name
   ntfs_lookup

The task never returns, and neither does anything else that needs the
directory's mft record.

It takes one corrupted byte on an image from mkntfs: change the first
byte of the type of the $INDEX_ALLOCATION attribute header of a
directory with index blocks from 0xa0 to 0x00. The first lookup in that
directory hangs.

Check that the index inode is non-resident and that the vcn lies inside
it before every index block read, and fail with -EIO otherwise. This
also rejects a negative vcn, which was only checked on later descents.

Fixes: d9e00c457d4a ("ntfs: serialize resident iomap reads with mrec_lock")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index fce10baa2..9fb5bb3d3 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -308,6 +308,20 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 
 	ia_mapping = ia_vi->i_mapping;
 descend_into_child_node:
+	/*
+	 * The child node has to be inside $INDEX_ALLOCATION. A directory that
+	 * lacks the attribute gets an empty index inode that is not
+	 * non-resident, and reading a folio from it locks the mft record that
+	 * is already locked here.
+	 */
+	if (!NInoNonResident(NTFS_I(ia_vi)) || vcn < 0 ||
+	    (u64)vcn >= (u64)i_size_read(ia_vi) >> dir_ni->itype.index.vcn_size_bits) {
+		ntfs_error(sb,
+			"Child node vcn %lld is outside $INDEX_ALLOCATION in directory inode 0x%llx.",
+			vcn, dir_ni->mft_no);
+		err = -EIO;
+		goto err_out;
+	}
 	/*
 	 * Convert vcn to index into the index allocation attribute in units
 	 * of PAGE_SIZE and map the page cache page, reading it from
-- 
2.53.0


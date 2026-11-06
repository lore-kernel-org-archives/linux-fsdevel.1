Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956482;
	b=K29ZRCHpTxgmoI7HKFP4VYJ09FH+NeY0Tidyda/gGiLT+2BvB+ZeoyN8vmhGZYyWvQkK
	 18IHp5BZ0wMNUgkhjAwX8BURvgz3KF+UhRJ7+g9os2vplfk72UumFGDtKKPBI6Hif1b9+
	 JQ8QyzRLU59NiPNyxhZ/J7GeOYvbwHjSR5EPeRth9kUOcAQfm2ZSWkOUTev7GGbqo9hTm
	 rkzhkINslz6r7z0zwuusSYQVLJTRC2krT78RusEvUDwq1eIKXVsRPsarG7AohjobliFAx
	 lb/l9hvS5oM00AQbfxAdlYJvuFqcHjWK4K3YuaevutYlBzEvvux9HCedxg/6ZB1G2aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
	b=dGvGzXPglTLdkc+8BNwb2GAtiE/VF+/UHizpdy7/kXaDGWu3Ow6WrCV2ktSsW2MoJ89d
	 fTL1SBF0HTg5gNTB4JUezYPMeVHwEIZDe2Dr2hQAstVSlfGTaCCOnSd8cYm1D5V3qBjZ6
	 trauQ2Fp5pms9mQBH0MfO0SbAqxWN4kTZqdU76mZlpCgYjwVD/Wzbpvi32spE6uQxVuRd
	 5Ua/U1UZtkQF2VfuD0kVYBX1Idi8DL//PNe6m82pSduRQLt4VpVKK60HAZf3cgPoXvuzt
	 xskuWicH/bvvUGR4gcFITY+Z1UwN/kj7ByXLAKy4Qy1ZzcY0HgsXa6YXqLAAp/ay55Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1vVYBAu;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222A606A32F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A222A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1vVYBAu
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so599558c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956481; x=1794561281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=O1vVYBAuspiUR1oomZmXY7dNsJ7oNWqcp+Lup9ffYYr5jDbW7HIniF9XbY/ets3sgp
         nZbXrrhsH7lecYgvrl5HG3xX+0KIuw5/R0tN8+LjuV4HnORN458aCRch/xQx9q1umg/s
         vsIKr6YrT8nVKv8E2ITY4upXOncrt6fvVvnMtdsUojkDw/yFTejiL/prlbMXemrBoUW/
         D5ArnQZ90Zxzr/1snmTVUOefMyhxOf6Im3/XgOaXE3M2vQNlIccXrdqjpp9sEZNba6u8
         lwbDDbKhNAW2e5fPw4WKS/3hgr72Dp6tluEyk9gz0cUKOKLSas6WmYWqoJBGlxndcQ63
         Pg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956481; x=1794561281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=Y0svUOFa3OYk4MprHNUBoXTC3lDSyYf2woKlPQFEsq6+RaV0zMwgR61UVd0AemD8Vq
         GW9K8lMDuG9F1lXbExnryVkkBcdMnzY3veSQ4sXu1jh+k/0p6xG5KnDvb4JLr6xR+613
         giVls/T5CPAVq+LI998fzabpKI9GzoWxnryql77kcm/tcQCUkofmr1NzwsWCjPkqm/sb
         7X9exkOSaxDVEjkz52NXWS8uNWPPBvmA0M6PxMq8ZOGSCC4Fx7MNmuEN4Nf5A8D9hwkm
         dF/YZw+geY3E5qHkCfZPLg+wKkL/MbaNyFUrkJdRqhPfBPmTCQqxPdEs09zAtAHvJbbw
         3MdA==
X-Forwarded-Encrypted: i=1; AKwUvBwboNORLNk9vz1YON5U0FiLmcAnLcy7dRujtAgbfQ39OW49lO0des8zaPaWOFK7T24l6MH3S/wybVCpdmN6@vger.kernel.org
X-Gm-Message-State: APuU4Z/pv+avhDvxYX//e/fy1qV5IaqQ7YyFL3SOIqoXP/J8Hx1i/qUk
	k3lX0CShkrSH7ssauLsNrdM/7hU3cRfpRFTFrsQoN/SViaP/wlYJn5WR
X-Gm-Gg: AYBFou2Bk/73fK/xS3HU0Fav911HoY/K/P7mIN+Geg97SqHSgWSg6xYltTKtDkEm8bE
	pGso8tGuxvUwOMSStcn/h6lcmxn2RxjpdOtSKktF96uIwYiK6wohpjLEAvIDO1aa1Vw8J+X9G1Q
	1NmxCZt4siy9bvhuYTZpK810ttLzJW0GevqwURtYQ6L3zyFQuChsjxjMgD6H+vRKQ4exuMDVkzG
	QysCVKxWwOHPi6yBgc6nNKWbXopcjDYQ5pYg7wEX9VUuldYSq+utLgAIekITFgni3ABf/F7452i
	NrxYnImnZC+FD24gBcjeJU18Q7gcDnb5qKpnHahURWlHpap4h2nPvyD4hfn8wDZ64grxlzPNEJG
	t2lSEQwMc2rPlmbc+7zQJNWGcIl3NFvU+JszzKICebjekBr/VXgb/6kBu7vF3Xb3zJk9U/c1kt1
	uJVwKFYlArvxfbul5viIaKzlXkbrc+pyEjxnHupN4yLUqxGYN6isHkn/CokisiE6eAdQNkZd4wT
	mdRlhJYegO5T+OpnLp9Mg77d0ES18JG0bjfDOiUR7mjanDgj+nxDmAlI1JZvKxK9YfRHcEqkXFf
	ueBnOyLIjgfkicUF/E09XVZGZ8WqFMdq8jN1xLyvXRIJQfDYNHMNcECmxslH4c9YgQ==
X-Received: by 2002:a05:7022:2097:b0:1b2:4c54:d976 with SMTP id a92af1059eb24-1b25d34277amr1679882c88.31.1793956480611;
        Fri, 06 Nov 2026 01:14:40 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4200968c88.7.2026.11.06.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:14:40 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ntfs: do not read an index block outside $INDEX_ALLOCATION
Date: Fri,  6 Nov 2026 14:44:18 +0530
Message-ID: <20261106091420.2461683-2-wahidzk0091@gmail.com>
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


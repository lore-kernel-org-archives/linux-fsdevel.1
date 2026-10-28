Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222533;
	b=ML5w38R4I4jotUl0VLV88kZel8ihYkyUYHMHJvHmOJ6MFswkHRZhm0VhMheqWRApCPBT
	 /H6XHt8H7OqRH4GKjWDi7UAW/Zsw6QJcIqqnWYkIvXtWbVO8ca2q3FIUC+ZOFB1R3o4zQ
	 9ZoEKLttB81sO7bsVYfnFklueVN4FvzGqIhbDCHg3CWysbM8dP9zSzES86ih6827ASu5J
	 oGkKD6BKSqakOfkUcwaLp5kOYDn5nASeo6b1aAjXPsm8wyBE7RCUl6JcZkHixXdlDLa7Y
	 E64LndNiDrIo1X+kLENdZw9K0lz72MibWuQf+RKRB7yDKjdwiL9YPa842mnZz14qDgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pDKBmS6WYnfb6Q8TXF/5+aSfNtslksEYbf4eTsPewHM=;
	b=x1cvmKxft5AozZubVLg6mjHPDFftFZN6H0oDp2FNH2P/jke7qs8D4Z5xaHj/PNpzgzOk
	 mBLQPTPw++DEP7hPf6+NeFnFta9ULeFz0D1FEnYaqoE8Wo/DZEDU47XzfGkRH75Zo6Izo
	 qs78D2RSkrZCP8nsRj+mwn/n9t9WxCeDgeFLgjs8yagRHYfEe9mD35fJeOaHWRKLQ1KQm
	 9r9/QZqt6wNjjUM2RmJJXFtpYJqm8qQxXoZX5AKdjrIWLJ0Eo8RyPcFK9/Q+vO6Tslai1
	 eRClpR9DfrVAXNRK934ZyRrao4UNHhxI2mh0J0fyxpZmadCvrv6LZsSdjPPiTdIDDTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hr0QV9XD;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6762606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 21:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6762606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hr0QV9XD
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-164f08a9e84so341363c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793222532; x=1793827332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pDKBmS6WYnfb6Q8TXF/5+aSfNtslksEYbf4eTsPewHM=;
        b=hr0QV9XD1SS73k8nOo/XPZODLSu9M1wD+obtp/bS8eiJLGS3MqmodtWAxb3X8eVpzX
         CoEcuZI4AZm4vfAUxoro2OPAVScaXOEE9gmNSIYjTAsAuxydgW8yYvT9x66r0Zni+eCL
         8xwBV2nTyItvK7oJCwZzgpuvjsE1ntUxa5So1LzhbEchVj0SKzdouo2Khycp3HLwTgBK
         0dafDTQFWwqgPBwBIHCdZCoRDk/TNYYjdZy1Tuj1CTgIwAQfANz67wIzuL8ErsFhPVgk
         xnzjqk/vbOaFiGtCYlNaYA5H0le1eoFd+lFw2vKGhQJ3GZWsEp8sMKLMXU0VWP1xVfPP
         odRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222532; x=1793827332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDKBmS6WYnfb6Q8TXF/5+aSfNtslksEYbf4eTsPewHM=;
        b=ZfkxCk6vLXeLYHZXYS2dEZMwloC3MU/YC3nwrUbFLqEcpx8tBLzjiIjs0LEZBvjsDi
         JhdFJY7bBS0ENkDhyqF2DkWSyOJNokkSaNdo///YGf5sBgnZ2+3vmkpXW0/7NSTzGMbX
         dUkUXELoMm04DJ+MecDi0tc2430joJfB3d/jmi1vU99kDDeAOyvnRJ0+MXmOGYXB41/M
         hLZPPoVZU7cC4KtgIXLKTNI+pczEgJTfm1KlRer/gKw8chYi8Mi8+QcyBWrlxEzmAKMa
         Wuunw4eVFPO10IJnoiryd3gOWbQPs2jmRkJQ7VRNVDdvL4LrozrzWbzr/gzOGpC8cosR
         SuDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyqo1BfWG4MKaMOdUDrParPJNQ+u5IQavvHKcrIzW/e+jjIHs1gX54mP4DGckByJhjk/ruGstUswWzU3Ka@vger.kernel.org
X-Gm-Message-State: AFq9FYIFhzLV0gw1G8mLoxFs4ut68SulOKYbOXmKiNFLh9TCfEKCeuVG
	z9eS7gLha87VqEijciqm6FZMqB0h/BjP1novTJztm168dnqx1tgAj3+Y
X-Gm-Gg: AYBFou0pIcx+T2DKFlhfoHEvpNvKlnkueZay41mvhSkBFXJdYJqZHqjDsP8qm0jFoua
	GpMKr4Kxz9oYuLmXxKekOMAr/MJcAgDU+go2KDI0kfrN4z+BpF0MOKXfzcmOLrlagXIm18854nq
	xduVfvcMo+AUYY8KR0rGhCGR+9amt0EA4TuoBhF+hc90YFlrSvT5qoGpp7NACQs/EYlahTSzQ6P
	HV0K00f/XtfSUkK0miLfVZPBeBWfSAD4RYrjldENLSZd1K22VTC6XWQDTUknaWpbDCYp7ZtmAxK
	H4LW9HztJMhtN2Ondzq92DosKjLlxWFRRGQtcsY95HO+6q/7hn6EMO/Vr3XYkZULSkB4+d1+eFA
	Qg+/EpYWjjOrgHNk4/eL3GYXtE8CiM5UrVzusMGtuy6YdOGtzkzPO1MFZRzI4XeOISMXaiWpuIz
	myTPWccLu85leiYsMCLHmJ9zOxjL0shl7yCoU9fUZGc61OyWHTwCRhlMsO6vRR4oROw3aJspRTb
	Wbz5jurssl0XDiHujRCyVZ4Bmn/qRv72jDCnxlraQpuUEvktOTkWpW8y+ceDLUm3GkC/MS3BwsC
	zwJODh4fDYm3qkOE6Z+TBp782rn/EUdik17wMUt5fb2w3jvd9h2v5Yvt
X-Received: by 2002:a05:7022:5f0b:b0:14a:a6dc:9ca6 with SMTP id a92af1059eb24-1a6c7c35fdamr4297952c88.3.1793222531698;
        Wed, 28 Oct 2026 14:22:11 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75a37093esm7147776c88.3.2026.10.28.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:22:09 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: hirofumi@mail.parknet.co.jp
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] fat: fix parent link count when replacing a sibling directory
Date: Wed, 28 Oct 2026 21:16:25 +0000
Message-ID: <20261028211626.26103-1-dennylin0707@gmail.com>
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

vfat_rename() and do_msdos_rename() adjust parent link counts only when
updating the dotdot entry for a move between different parents. Replacing
an existing empty directory in the same parent also removes a
subdirectory, but leaves the parent's link count unchanged.

For example, renaming one of two sibling directories over the other
leaves the parent with four links instead of three. stat and ls report
the stale count, and find -links 3 does not match the parent.

Drop the parent's link count for this case after the source entry has
been removed successfully. Leave cross-parent renames, regular files
and the existing error paths unchanged.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/fat/namei_msdos.c | 2 ++
 fs/fat/namei_vfat.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index c7500c2859e0..570dd75dd275 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -565,6 +565,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		(void)sync_inode_metadata(old_dir, 1);
 
 	if (new_inode) {
+		if (is_dir && old_dir == new_dir)
+			drop_nlink(old_dir);
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index ff7652bf0410..d7e2df5bf7e5 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1011,6 +1011,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	vfat_update_dir_metadata(old_dir, &ts);
 
 	if (new_inode) {
+		if (is_dir && old_dir == new_dir)
+			drop_nlink(old_dir);
 		drop_nlink(new_inode);
 		if (is_dir)
 			drop_nlink(new_inode);
-- 
2.43.0


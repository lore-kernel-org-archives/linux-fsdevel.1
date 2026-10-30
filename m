Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350934;
	b=cQR1DgpjuECOWabtZFm52HOvaT6O8csEFp9btrGXM1+qO/m8GhUc2+eUO+ZmuzJCfQ8F
	 ZPRuLU4NmhjHPreIrlPqTmPQtmnlH5FaGET1rktod2wzgummJCD5qqMeC6WF5C6ACxTyQ
	 VqZ9BSFfG6doaaukocHV5ATGs40P+75LKVb+cFi72vGRQ08SK7PymMWlWSbiE3yRJfy3j
	 PK5gk57EFeA5ss5InaqBxFcq0QHFp7dTNRp9HbkElWynYESOgfpT9vrnhcghnHw9aVoCh
	 AWidnV74QnxCXB96E1bK9qm1rZMA3yNYVWUBsUyAP2HXmP0PWrH/wgqRRPwuDYMh74Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Mihb4OPZBic55UeIz2xeg7uf8TjtjfwKjVCpWgCi8w=;
	b=RGRHF2EmFftb+XVK3bgtVhM/nE7P8KW8w6xKBX+kddLncLOBlpYbSuVuyjdeI/dmRbZL
	 K6xhnC35Pv64P4zoo5KbvliUGWS2iGbjhiGpPJh0RrV62a8QoqMDNetXY9QFpHA1YrZ6K
	 0peEoso+otUBTqPOhehFRM4HxhGDR2sJe7Kofo/NqHhwbNfnQ5m1cVHzKP5RZ09S4UPzd
	 cJARmu+Ia8Wo9NigzLX+dYg6M+SlNKaQRjqzmcLQ1xf7GdXJ2+EotsFKRsIRh5GzU8CCU
	 jORl3Wt+HRghXfdDn8QSgYs1Zo3tH4w2IelZf9q2sDCcMmTHcFT+k4SFv9WefcF4z2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="dbg1/IxO";
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162F606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 09:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0162F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=dbg1/IxO
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5363c8de563so5356691cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793350932; x=1793955732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Mihb4OPZBic55UeIz2xeg7uf8TjtjfwKjVCpWgCi8w=;
        b=dbg1/IxOZ96hc3CHweDCGa5yfW18aW/qdKsZ36dESwYy/4+LqKm2LjwafpEoenOP3L
         KBnEKqqo78/1KSRUzRUK6zksH0nLRI638ih3w+LnUILAhwxqz1/TnX/HJXnll5CkPT0E
         U2qRG9IaXl1/2fITjEbMrYdEfGo1kLQgziGPtHlCDUYOwQCLdgBix8QuBT10F7jH9iso
         ZcvTyx7jmmrTYaxKJABa96QcNO9gFYVjRxOuoDk/eFUDkcNpuM4ABcgYI8ulSSXsGe3y
         yaGjTjAcpSJMroXXHfANtFep8YfXmGERoHVZiEr34KvHUcBixyM7RxLaL4tZ9EsNX0Mh
         kqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350932; x=1793955732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Mihb4OPZBic55UeIz2xeg7uf8TjtjfwKjVCpWgCi8w=;
        b=Qx+/egqH1HdnJcGtw7cs2JxCkGr9qkUui/lpfReeDQg8e+wad4UwHe2IDSl5TsEUBn
         LVesCztpcgpYs2s4jjcCcH5aITSaUuXHArYwiQDYocHZmEcb46DX88IsVpzKnUMm9xSa
         qufrVwjD8UgZbd0V9jFyw3gCzK6pTHk+rVtTFMbo52n4QCWqqIqDKqOC8wa4gFKJKcEj
         eAR7dlkXjz8d3+4s81OVqZFcaVuhiB5aIrlOC2mhsksj3VFIFyjPmuxdWmUDSMT22WrB
         5ir0QuO7KbGGM/Ko2UlL5OE1lHRuvRgRQrK3GvfAgEglYkN0oPYTmS+9+sLjoL01uhsF
         xBQw==
X-Forwarded-Encrypted: i=1; AKwUvBxkwfgAemFS8Kmke+09NIHzEaD6WI62VzydEgiU1oiAYQvYaqQkcNXkudc6kuf3Z2Hd4029gA7d7Ynpc+p8@vger.kernel.org
X-Gm-Message-State: AFq9FYJaa9aP01iPsg78niM9Bj2eldgWbVj6tIbBCW2+D5JwytTLqE0v
	iu0r9P4dZMy/st2EZ0DaOtvINH0iPD9qi8Vk35MX57EeUAKNLvQcdyny2dR0pC8K+Q==
X-Gm-Gg: AYBFou1aPkRfqAz1wt3LKzkCNInHYufgkg1gTQwMTVGjVfFneWAGx7Ee+ckmcWc/2ui
	dB2xpHqdu4pch4ecvxsiWWPsl/2BOOc0HsyefbyrEWps/6TS401/a3iweo6Agb/oqN0ks5KWUBJ
	Am3BETK+F+bO5DEQXsgvUyHZAOF0LwsYE9ftvqgb0Y/8wGyZfF9ej0UNnurfFXJ0y2ZXrIXpM44
	NGM80bsEoFkqbuE8e30OwO+OsVgoSLnYWgMHRyuN6NNKf5xba2CirlgkaRJjzOwm+cWlYeeVGzq
	ZXfNLm6x2q67vCaGJlG5BFnblj210fI6gaPMdtOacpUevDbhhGprFxTVXTnMgy8vIlRky6dm8jo
	S1h/UpsljsLKXLIWvNO4k34xnI17upbMjfjIPfBnvRzlZW9KoZKDA6fABT7wPPXv/FAbeX/sJyp
	VXiVpzgbVDgs+LFdmpuwmgfMcEPO+MOT9KFcQaxdOwIeC/qLnF5x+/NMfrgFCnjlaXLnEW2tZlE
	1l/52CJ6x4h/cL6P/zqL83HDWvOT3YORbZd+luOY6mD7Vw+TKXdt+vHmIYjNam5PoEKVB/X3W8p
	1A3T0ZGAsD+z9b7d2HaduYM+gJBZqgsWu4l0QL9+IXy+viyLIM5Q
X-Received: by 2002:a05:622a:408:b0:536:2fd8:a4d8 with SMTP id d75a77b69052e-542b6689ab9mr23251791cf.15.1793350931563;
        Fri, 30 Oct 2026 02:02:11 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54313234047sm8404251cf.28.2026.10.30.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:02:11 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: hirofumi@mail.parknet.co.jp
Cc: brauner@kernel.org,
	technoboy85@gmail.com,
	teknoraver@meta.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fat: check for hidden entries before overwriting end-of-directory marker
Date: Fri, 30 Oct 2026 05:02:05 -0400
Message-ID: <20261030090205.279419-1-hengyul@cs.unc.edu>
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

Since commit 6a2875517c77 ("fat: stop reading directory entries past the
end-of-directory marker"), lookup and readdir stop at a slot whose first
name byte is 0, and fat_add_entries() reports corruption when its scan
finds an allocated entry after that slot.

The scan stops as soon as it has enough free slots, though. When those
slots include the marker, the new entries overwrite it and the allocated
entries after it become visible again without being checked. A name that
lookup could not find can then appear twice in the directory, and removing
one copy leaves readdir listing a name that stat cannot find.

For example:

  mkfs.fat -F 16 -C fat.img 32768
  mount -t msdos -o loop fat.img /mnt
  touch /mnt/aaa.txt /mnt/bbb.txt /mnt/file1
  umount /mnt
  off=$(grep -obUa 'BBB     TXT' fat.img | cut -d: -f1)
  dd if=/dev/zero of=fat.img bs=1 seek=$off count=32 conv=notrunc
  mount -t msdos -o loop fat.img /mnt
  touch /mnt/file1
  ls /mnt

lists file1 twice.

Before using free slots that include the marker, scan the slots up to the
next marker and take the existing corruption path if one is allocated.

Fixes: 6a2875517c77 ("fat: stop reading directory entries past the end-of-directory marker")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested on x86-64 KVM with KASAN, comparing mainline at d89e1d186ec9 with
this patch:
- The example above: the base kernel creates a second file1, which is
  still there after a remount. With the patch, touch fails with EIO, the
  error is logged and fsck.fat only finds the dirty bit.
- vfat, three-slot create whose free run ends exactly at the marker:
  the base kernel exposes the hidden file, the patch returns EIO.
- vfat, one-slot create that leaves a zero slot after the new entry:
  succeeds on both and the hidden file stays hidden.
- Valid directories on FAT16 and FAT32, msdos and vfat (creates, deletes,
  renames and mkdirs, then filling the root): the same entry counts, ENOSPC
  on a full FAT16 root and no FAT-fs messages on both; fsck.fat -n exits 0.

 fs/fat/dir.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 35bdb62944a2..ab99d53a719a 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1318,6 +1318,32 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 	return err;
 }
 
+/*
+ * The free slots chosen by fat_add_entries() include the end-of-directory
+ * marker.  Once the new entries are written over it, the slots up to the
+ * next marker become visible, so make sure that none of them is allocated.
+ */
+static int fat_check_after_eod(struct inode *dir, loff_t pos)
+{
+	struct buffer_head *bh = NULL;
+	struct msdos_dir_entry *de = NULL;
+	int err = 0;
+
+	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
+		if (de->name[0] == 0)
+			break;
+		if (!IS_FREE(de->name)) {
+			fat_fs_error_ratelimit(dir->i_sb,
+				"allocated dir entry found after end-of-directory marker (i_pos %lld)",
+				MSDOS_I(dir)->i_pos);
+			err = -EIO;
+			break;
+		}
+	}
+	brelse(bh);
+	return err;
+}
+
 int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		    struct fat_slot_info *sinfo)
 {
@@ -1351,8 +1377,14 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 				nr_bhs++;
 			}
 			free_slots++;
-			if (free_slots == nr_slots)
+			if (free_slots == nr_slots) {
+				if (saw_eod) {
+					err = fat_check_after_eod(dir, pos);
+					if (err)
+						goto error;
+				}
 				goto found;
+			}
 		} else {
 			if (saw_eod) {
 				fat_fs_error_ratelimit(sb,

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.53.0


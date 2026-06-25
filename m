Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5972E1EFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372827; cv=pass; b=jWe5gnLjRXjzThtJVv+RyoN1Oc288SQlFvrojhAOIpd5juXxwzPZ5t5p8ZUCebnLRNjRul/fepM+yhiK6n9yoj9y2sx9DdgLsX60nfe7rLKk/cpB3dXB4i2b3uNciQU4rmrY8K+BmUOGLxDfnr5+PhL4ZewCu5iIAhuZmwNac/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372827; c=relaxed/simple;
	bh=Jni+/Dkckw9/tarmoOPQcrvWahAyuegtTzcAJvVUnKo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i/ZgmhTniLK2SDsygk9kys+5SuwIHhDAJ6q3PzimfS2i/QaPU6nlIgDeyhKZXriRDy7GLf6H/vWjajIJrvFE8herJ/dgp1bf+paxu9pAcA73AQxe3x7fBn/CZpr62HNOoMUJjaVPsruKvS1JsFZvrW1PqXeqs38PF6SkyrHiUXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXGwFzp5; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXGwFzp5"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396775c2720so15682071fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 00:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782372824; cv=none;
        d=google.com; s=arc-20260327;
        b=gRS8/xXmy3vj6OiU6R+pk6Q2zxtRUXbsHuKqhSVfsANBu8Tby+bG1jBG16px7GAPJj
         56XzxMQAFXz556mDexCkuvqep+Gdd5PuNGNig3pZJMuI/3oPZL1/r/kH4UoIugygzh2I
         7e6mgE9Vj8f9XdNqOAF8G2/ii7Fc6cJ5bOuZLn3+SYrmJYv31e7BjIBU5fXYsRRzhUMx
         L9TpgCaN0ct18D3tjr3/ePdb1Z96rzjHUnv78ozHiUR/WFjndOY5vgC1Pi9QLxfU4X30
         FcZU/E6hSakD+HlludAg69QtAeJ1b8C9HX+7iEVwErmr1xw8FsEGxc733FRM/6AFvmCE
         Fssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Jni+/Dkckw9/tarmoOPQcrvWahAyuegtTzcAJvVUnKo=;
        fh=085PXWA1ygQwQDiW9Iuq8/qY3H//r1AeeSiiGD4SqNQ=;
        b=jG3e/FsZ798ZuPvXKSIeKBX8GYHmqTMT9BuB+RLrMrLgffMrPubkWehnOxJRAl6agH
         fCsFqaXb+FVAgwZ94G24qrte1O/TtmqVi1R/VSCh66NqyKnOoCfcYnEfxPQFbwXNDZ4P
         qtXRdw1GGJJdM8tgBUQNJAm2JJwZ/AgUJWY9/UY9xKhXGAmh+wzct7JW8HV5E3HYKUEz
         EajQU8P2amBr4F9EuAiTSCeUG15HfIH0qS84aqcCeEB8XY+L6Q4zyOisYcXRjrEg/01S
         A/wp3ShsPEtCQd/KZw99QqcK+D1smw54/CcIYqGIbl/wjiS7jtNuqwgPgiMAABATj6Cq
         Gz+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782372824; x=1782977624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jni+/Dkckw9/tarmoOPQcrvWahAyuegtTzcAJvVUnKo=;
        b=YXGwFzp5lFK5NAl2+rImH7hax5jCns94XiuwWDjWkl5QgrJ1VrNMh3Mpv0o6a3U/sI
         Nb9ThAkDdOAx+YtqxYFmFof6WCr3r2H8yCyITAKbifPCe1bWd7n+OSN05/AEsUqsABbY
         A2NZsLgdd9snRYz3v9aQaEDLk4yLlJF8QXdOL6Prmw5cwNXlh5nj+OfoqyQEES5bdxmS
         hrTX+8axasymThvGzBTWcmWrE+0saGof4ajEGZAVow1EAkU7Smneqg3UgAKww5pL85+5
         Y//QYakABSax+tMSVlf0JcUBZtlwUVXoA4QPVZdE4ex7lvDiSJSAIr1RD3qjrwuworzp
         twQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782372824; x=1782977624;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jni+/Dkckw9/tarmoOPQcrvWahAyuegtTzcAJvVUnKo=;
        b=fKwdfIxCVebRqJ90mzeVpuITjKM0fY5AY7OUdJ7YBLqboXFrhIdsC8sd/W2bNnG4bT
         PfAPsKc8gIBPp36nHYPkMJUsBinVPRlsUgDqcdDAYuD2joApXfB/079uC4Nv4mxbrSZO
         p8liLsDoD02UH8XASj+GAydn0ETBBkcVfoAyBDfsH2PRIkVUmjOb5aUfyj7VUifphs04
         wu0UU/T2clx9LE9yKxU5+3xkHMgeBuhY/mSFjMMmg+gNz9f73+Kh73+kFN/wl5al8vsi
         BWXPqBd4fkwbjEcQFfxxsekMlv1OGBacCJXihQcuevISkO8myyWf+ZkTJrZdnMHe+R5m
         jt9A==
X-Gm-Message-State: AOJu0YwWYewQ2pqynMLV7CrRCaPziGzIgOIp2WHiP/O4HD8SiE2Gy5xN
	i/zYHhX6QPnUaXl6tf+5aDl8kWHYb2U3+wVdL68GJkoHUxHrZiTOT9Gih3tBhLSRUTA44Rpl2m/
	EAdOh9+OtyZ1AOGvNBTf0dr+UamF5Pw==
X-Gm-Gg: AfdE7ckw1lAOtt/VYhgX0GBmWiTVFyA9p/byu0HddyM/auxtgX4kHBEEutq8Z8ShX0+
	OHDDrK4582aolAspYDlbCfLX3VH4hqky2OoWJLIs36fRBLoxhmJNV3iDy81OiJOqiAoH5KOpHHJ
	8XrVdPWnhH8xr0B/SjwlXrXGoDoj+zY7ZVWNfdSX3tLvrReiGCqmmq+fBEtEeZgFS+oELAk5XSI
	FZKHGau0pF+arWG/6nJXtdOEZPQqHUITvyri0ciyy2dVYJHnf+DiwML9yT9HMkt82y5wy6D1yhY
	UcfOyjimDC2jbHa5yn2rAlRbm9l0HGwE37vUqnC/zuggk1DnDPpDMWFOUISeWDzVbfXzvoNJKU6
	CsBtt5ULZS2D/JuTeFZrqbaNa4bX/zR/iddpujwSphG58MUk=
X-Received: by 2002:a2e:90c4:0:b0:396:b398:5956 with SMTP id
 38308e7fff4ca-39acb6ed093mr1781811fa.16.1782372824031; Thu, 25 Jun 2026
 00:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Razvan Dinculescu <razvandinculescu@gmail.com>
Date: Thu, 25 Jun 2026 10:33:32 +0300
X-Gm-Features: AVVi8CedA17YdplB37Zjfo-797nci9e9zwKPYoMSHyfUShYwcILJfB2Oxflbrd0
Message-ID: <CAF3PHDynqk0fbtthp8cPQCtgFajrjNvCxmDp8Lq=Gs4TD=ztgw@mail.gmail.com>
Subject: ntfs: RO->RW remount is broken - two bugs in the quota-marking path
To: linkinjeon@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namjae,

Thanks for the new in-kernel ntfs driver. read-only -> read-write remount
fails on any clean NTFS volume. I tracked it to TWO bugs in the quota-marking
path and verified the analysis by building a patched module against 7.1.1 and
confirming that fixing both makes remount,rw succeed.

(Resending in plain text - my earlier copy was rejected by the lists for
containing an HTML part.)

Reproducer
----------
Any clean NTFS volume (reproduced on two different disks):

mount -t ntfs -o ro /dev/sdXN /mnt/x
mount -o remount,rw /mnt/x # fails: -EROFS (exit 32)
umount /mnt/x; mount -t ntfs -o rw /dev/sdXN /mnt/x # works

ntfs_fill_super() never calls ntfs_mark_quotas_out_of_date(), so a fresh -o rw
mount is unaffected; only the RO->RW ntfs_reconfigure() path runs it.

dmesg on the failing remount:
ntfs: (device sdXN): ntfs_ir_lookup(): Failed to lookup $INDEX_ROOT
ntfs: (device sdXN): ntfs_mark_quotas_out_of_date(): Lookup of quota
defaults entry failed.
ntfs: (device sdXN): ntfs_reconfigure(): Failed to mark quotas out of
date. Cannot remount read-write.

Environment: kernel 7.1.1, x86_64, CONFIG_NTFS_FS=m. fs/ntfs code quoted from
torvalds/linux v7.1. (ntfs-3g/ntfsprogs not installed; in-kernel driver used.)

Bug 1 - wrong index name in ntfs_mark_quotas_out_of_date() (fs/ntfs/quota.c)
---------------------------------------------------------------------------
ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino), I30, 4);

vol->quota_q_ino is the $Quota:$Q index (opened via
ntfs_index_iget(vol->quota_ino, Q, 2) at super.c:1235), but the lookup uses the
$I30 *directory* index name. ntfs_index_ctx_get() stores the name,
ntfs_index_lookup() forwards it to ntfs_ir_lookup() ->
ntfs_attr_lookup(AT_INDEX_ROOT, "$I30", ...), which finds no $I30 $INDEX_ROOT on
the $Q index -> ntfs_index_lookup() returns -EIO -> "Lookup of quota defaults
entry failed."

Note there is no global "$Q" name symbol (only I30 is global, defined in
dir.c), so the fix needs a $Q name added in quota.c, not just an argument swap.

Bug 2 - ntfs_index_lookup() returns the KEY, not the VALUE, for view indexes
---------------------------------------------------------------------------
With bug 1 fixed, remount then fails with "Quota defaults entry size is
invalid." In ntfs_index_lookup() the done: label (fs/ntfs/index.c:838) sets:

icx->entry = ie;
icx->data = (u8 *)ie + offsetof(struct index_entry, key);
icx->data_len = le16_to_cpu(ie->key_length);

i.e. the entry KEY and key length. For the $Q view index the key is the 4-byte
owner_id, so quota.c sees ictx->data_len == 4, which is < offsetof(
struct quota_control_entry, sid) (== 48), and bails. quota.c - and the
function's own kerneldoc at index.c:712 ("@icx->data and @icx->data_len are the
index entry data") - expect the entry's DATA (value), which for a view index
lives at ie->data.vi.data_offset / ie->data.vi.data_length.

This is correct for *directory* ($I30) lookups, where the key IS the data (e.g.
inode.c:2609 reads icx->data as a file_name_attr) - which is why it has gone
unnoticed - but wrong for view indexes whose consumers read icx->data as a
value; quota.c is the one that does.

Verification
------------
I built fs/ntfs as an out-of-tree module against 7.1.1 (clang, vermagic-matched)
and swapped it on a live kernel against an unpatched rebuild as control:

- unpatched rebuild : reproduces "Lookup of quota defaults entry failed"
- bug-1 fix only : advances to "Quota defaults entry size is invalid"
- both bugs fixed : `mount -o remount,rw` SUCCEEDS (exit 0); the volume
mounts read-write; directory reads still work.

Suggested fixes
---------------
1) quota.c: give it the "$Q" index name, e.g.
static __le16 Q[3] = { cpu_to_le16('$'), cpu_to_le16('Q'), 0 };
and pass (Q, 2) to ntfs_index_ctx_get().

2) For view indexes, expose the entry VALUE rather than the key. Either make
ntfs_index_lookup()'s done: label set icx->data/icx->data_len from
ie->data.vi.data_offset / ie->data.vi.data_length for view (non-directory)
indexes, or have the view consumer read the value from icx->entry. A blanket
change would break directory consumers like inode.c:2609 that rely on
data == key, so it must be type-aware. For testing I did the latter, locally
in quota.c, to avoid touching the directory path.

I haven't prepared a formal cross-index-type patch - flagging the two sites and
the mechanism. Happy to test any patch.

Thanks,
Razvan Dinculescu

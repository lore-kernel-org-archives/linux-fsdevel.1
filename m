Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823E38AC75
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447758; cv=none; b=qgkyYPZacRX1eYO0sEOWwsWSL4VC1y59XTmdiaQYloXhZ77SeuMyQX5Ug7yOUCQls5DlL8XYDN7/K2hXYeV50Kla/QhTqO3/oHFvvl38PW0O3LxBZdqLh4azsEy5Vwl2MHxx1L8jq2HNf2GpjJuYcxabd0dp4t0qVU4prjy/Bug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447758; c=relaxed/simple;
	bh=GqoxNYrKWrHLTOS32Bh7pPgYBmkFx8f61Mqt5sQ9fho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h2Z0EHcXjjIKbPukJ4P97UAC1Oigm1UjaqphhZCX889J5Y6JpXFd7YotJ7zNONsp+9/Fa86N1cPms9y47d9tsquOU3uPPcRr/ezFvUAHiTqg06NSs9fMsIQTzH3bSiXY2gnD3QtuRvbnuvtyXyOA7GE34oL6ivDM05a2o+4tArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QEUmicx0; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QEUmicx0"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso19109675ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789447756; x=1790052556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIegXHIZsuD3zx9WNN+8dKdvGZzBPHkOC+B+FhSQZxo=;
        b=QEUmicx0CveMojzY2XW250PYYtvKMzZ+Uiwo/JdksSdgH+KxZFmDpCO/8NVjvFCxY6
         O+aZouruc54ftXBTJr1DT97Gd8IiMLkpj3W9QE/BWlRjBcc82h5rzf20ZHGJHs7J8KlD
         D+JqWSmi6PpkzH6Xo8TLosgptU5zsiQ+SzZReaCT3E1cSMqTqDhCZH+DUGC2lG0gf6XO
         LJO14w2riLvMnTz7ceQMVEnveH1VbFVlL+VsAvtkBwu9+QoLCDJXniWKXJdyijLUXx6V
         G9JBVsHgnyMqUHTHJi4wMkeNWKn+fYIJ1/4a7SbM98q7Gw2h47vtiwlObbHvzTolU2co
         wgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447756; x=1790052556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sIegXHIZsuD3zx9WNN+8dKdvGZzBPHkOC+B+FhSQZxo=;
        b=Zq4HXHZXwAuunGFtFQfLFuh5A1IKf7LOS4COKqAtmEU6UT4eVaqz7wVnw6Xvxju4eD
         nh3VWuNKhiNXb/GAUjnqo5MphGPFCK+Ds0h6kAyngtToWJmLAANYhWxdweXpDZIKjdNJ
         6BeSQdbQyO6Ts3hhXV05xeWt9fkgbmeFwqtgFVTMGC2BymfdR0DAw9pPiatW0xwKxafT
         9WGm5nPrvNU0Uwcj7x/yR6vbL1HlDCp/YjNdUkx6mpoFKwZhp1aTCaz2LeRKnOlT59DR
         erji4vYhD5jMPs5cYY7SV5MOHw6caeh/T2NZ6rJ2kc/Hbix2EKvRilF2yiVgCtdeqXah
         Z9yA==
X-Gm-Message-State: AFuF++nbvzbABC7Xo6yA/SWtByeYWT4CHK48cjR6ddBJGIOFdEzPTKWe
	mETuxTiYKzuJYFQfckDUmGRzvOYjIwP1EGRx7gEpa4EVCKVGLRwfpJQGhcVuS/sHI1mWtcteWP5
	GJ1YOyfU=
X-Gm-Gg: AYBFou36IThKfslxBiUrzXq3mJLkVNNXflkqs2CU9axd+69/K0aaM0Tfo6MA4rJKEux
	3tBD0YhV0lui5uVBVDvcv2gnG3K+jtA1zTP6QBKVNCy38Zg04K6ChBOjNih7JEmlKdLmTrL/pfc
	PZPmYvR7j7dDbx7B2bZhmy1Xq4bPn4N+k1ChhzXuPOhM46omZjbUiyJ3vU6TVgcWK+pzmqEZBPb
	tg7+YauGMJsfofJRzejWjJG0sCfMOZYaKtC1vpg6sptUZNhe0MVh/PNYmdsNB0hac9NMQdszMy6
	uTuapHHchKkROoXTUKskpaRcqL3Iuvmm/c/62Jp3Ac8aD0kNcJh/eKljD8itwwsvWZIXlfAEoYb
	/Cg5Agfy+TdFxisf9vrfwjZD9MtxzBWuQ8QaMEkwoKlCCMpZKw87wIeg+mWzL95Xmebi6ABnCL8
	3kkILOEtvx91yu1Iijo5MfWes8d1PLu8RF5EyfHaISiJmWF5WVHfMpimEpX7NBgnAwIMXeoPOpI
	ZI=
X-Received: by 2002:a17:90a:d64e:b0:39b:2c55:365 with SMTP id 98e67ed59e1d1-39dec07ab33mr11367709a91.12.1789447756370;
        Mon, 14 Sep 2026 21:49:16 -0700 (PDT)
Received: from localhost ([106.38.226.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd9badb6sm2698317a91.2.2026.09.14.21.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:49:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jbacik@fb.com
Subject: [PATCH] fs: avoid repeated scans in evict_inodes()
Date: Tue, 15 Sep 2026 12:49:12 +0800
Message-Id: <20260915044912.3183440-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed hung tasks when users attempted to unmount a filesystem
after its disk had been removed while still in use. During device
removal, fs_bdev_mark_dead() calls evict_inodes() while holding s_umount.

Each time evict_inodes() drops s_inode_list_lock to reschedule, it
restarts the walk from the head of s_inodes. With many referenced inodes
at the head of the list, these restarts repeatedly scan the same inodes
without reclaiming them. This can keep s_umount held for a long time,
blocking concurrent umount attempts and triggering hung-task reports.

Keep the current inode, already marked I_FREEING, out of the disposal
batch until s_inode_list_lock is reacquired. Resume the walk from this
inode and dispose of it in a later batch or at the end of the walk.

The zero-refcount and state checks under i_lock allow this walker to
claim the inode by setting I_FREEING and removing it from the LRU.
Other reclaimers skip the inode, leaving this walker responsible for
eviction. Only evict() removes it from s_inodes, so keeping it out of
the disposal batch ensures that it remains on the list while the lock
is dropped. After reacquiring the lock, reading its current next pointer
accounts for concurrent removal of following inodes.

The existing inode lifetime rules prohibit acquiring a reference to an
inode marked I_FREEING or I_WILL_FREE. __iget() requires its caller to
hold i_lock and establish that taking a reference is valid. Inode lookup
and igrab() check these flags under i_lock when acquiring a reference
from zero. ihold() requires an existing reference, which would keep
i_count nonzero and prevent this walker from claiming the inode. These
rules already allow iput_final() and the inode shrinker to release
i_lock after setting I_FREEING and before eviction completes.

A temporary __iget() reference would also keep the inode on the list,
but its release must preserve last-reference handling. Another user can
acquire a reference, update lazy timestamps and drop its reference while
the pin is held. If the pin becomes the last reference, dropping it with
atomic_dec_and_test() and evicting directly bypasses iput()'s lazytime
handling and can lose those timestamp updates.

Releasing the pin with iput() preserves that handling, but does not
guarantee eviction. fs_bdev_mark_dead() runs with SB_ACTIVE set, so iput()
may retain the inode in cache, whereas evict_inodes() must evict eligible
zero-reference inodes. The inode may also have been freed when iput()
returns, so the walker cannot then use it to force eviction. Using
I_FREEING preserves the existing eviction behavior without introducing
an additional last-reference transition.

The xfstests auto group passed on ext4 and XFS with known unrelated
failures excluded. No new issues were observed, and the previously
reproducible hung task no longer occurs with this patch.

Fixes: ac05fbb40062 ("inode: don't softlockup when evicting inodes")
Assisted-by: LLM
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ba7da39be4a3..a9d37be390a1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -880,7 +880,6 @@ void evict_inodes(struct super_block *sb)
 	struct inode *inode;
 	LIST_HEAD(dispose);
 
-again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		if (icount_read_once(inode))
@@ -899,19 +898,19 @@ void evict_inodes(struct super_block *sb)
 		inode_state_set(inode, I_FREEING);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
-		list_add(&inode->i_lru, &dispose);
 
 		/*
-		 * We can have a ton of inodes to evict at unmount time given
-		 * enough memory, check to see if we need to go to sleep for a
-		 * bit so we don't livelock.
+		 * Keep this inode out of dispose so it stays on s_inodes while
+		 * the list lock is dropped. I_FREEING prevents new references
+		 * and leaves eviction to us, so we can resume the walk from it.
 		 */
 		if (need_resched()) {
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
 			dispose_list(&dispose);
-			goto again;
+			spin_lock(&sb->s_inode_list_lock);
 		}
+		list_add(&inode->i_lru, &dispose);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
-- 
2.39.5


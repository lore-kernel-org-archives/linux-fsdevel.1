Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793135396;
	b=wVUfJxIyoQy33AdeE7XmBcgwUlCYyd/KrdzsSAu3qvv2OH9k17IOhNzEldxtVIb6nAwr
	 1Giz0Iu6AIeyBUmps1Rwqn+glNtDQ3QySUaL+w1UmIey4daCn3Z7fY0iSlm2Hh2NR1WHi
	 tVWN7Md1w5iG0FQHtRo7q4mWRZMj1aeN6DBJhGL3BtpVCmmNRm5WWYVimm1elyYGGtxja
	 8z57VDM/hlQ6oKeqeKF2UbukcHRrlDzhoyqicwzgeDzFIibNekrfEAPD6eLBMDYUxyKC+
	 bo7t64GOG+CKlVpD+1Ok/vDMcjDhJIkY/HIqpK8fC2kmUuYtKMza5yS01lGLKsMzrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IpMKT1cwbF2BM7+4MFg5CQwWFq73xTe9BXIlwTOQUCI=;
	b=XsQs+16FCE5QetqE12MV8kJxjW9iXMUR5aaEoY49boNOBSmiFVfV5L/LjU98U/wjWmrL
	 80hD0c+tgXlysXGDNR7ByEiQmM+adpzR9FMPXYbd0RxrWBZt/Av+N/fwY1tBDSxsEND3W
	 vlprJiiqYfiVzlCpPP82MxaozCmrE93+9l+lCzXGfceRtaqi1vb1okRB2VhUdo7TJuYdV
	 93ZCGuqCoqKGSQndZ8lGeUX8obZyBdc4T9CQgo7W/flp1uIsamXg+9F+HYBATbOKzXkpo
	 PF9KJ/QBKOCXi6EeJ33aZrKFPPB98NA4l1+5hK/8NMFUMcYOQNxEHvB1TF0gJICX9fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WnvvvdTc;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3FA60A260F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED3FA60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WnvvvdTc
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5364d86f7f0so5286191cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793135390; x=1793740190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpMKT1cwbF2BM7+4MFg5CQwWFq73xTe9BXIlwTOQUCI=;
        b=WnvvvdTc7G1nfaWX/xZKKnrICsgfAqeL0R9qFWLgI1Lu6RxgO3Y0j6JpA78kzWjYYF
         KyHoApYnqdtPpwWqfZAw1ZHZJU+FOrbBiHwQmZ71f/p1rv0nSKVSrveRfhtfsUqhDK77
         whvi1LUz+/OAAEmIQmJJBuXgJAoalPNrMrCHO8ICLrteLjaaazmRhnuZZB8693EsvC0P
         aFtcYWZhs+cUyb6MfKJ7TpwPzncqeXWQlaRPzHPMlLHVg9VuV/+ATMzV6LYkGnffpwU0
         nteEG1kjc7zbUoS7e89EOLrDTDoYhaVC660ZHf2WhRhQ+FzhUdOwf98TItMqyoculpUQ
         Q7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135390; x=1793740190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpMKT1cwbF2BM7+4MFg5CQwWFq73xTe9BXIlwTOQUCI=;
        b=D4aMCSZOTyimVKql148Y08tvtpTBH1ereS8Jq1hQbk9Tc1I3kqWiWbp52xVtjOYfZv
         T3TIgpo6Dd0HtdpqxdVLLreRrBkwF2LGPFJ3y8knS9KixbnN8X92A+N2SsCE2s1JE8hk
         ho7Cqc/5Rml1Zt0wjcpA7b4zPJOQFWSMV7J60/Sip06MX7F6sgYiBQ55uG61szQ3HN8G
         e73ycEQG4gFfm/srik2k39LEj2KfTYrTeoZyDOkmJ9GHJb+3i1+xngN2t6iPTqlmUK6a
         bY2SCNbdY1MxwrzkspPfBJdibRhluP0Cx+9JH8rpmjWsl/hAR86VEeudPUBXSIHMoOHx
         NEPA==
X-Forwarded-Encrypted: i=1; AKwUvByANg+//ScnuDgtnZDOLbGIiDZOeunguEYXUiPeoumtoIp6AZ1hfE3LJoNokrqvldrzr5D2TzT6XgsZrL7d@vger.kernel.org
X-Gm-Message-State: AFq9FYKDA/byXD4u9rfaz7g/UKWoDX+X+rcIkzEZy42yY3+YALs/dJfw
	CT5ORfFmqMNQ6dZgAa7ZWjHdhxmpTsRx+fSgRf6/fupTqUMfgeAc8YPsCAdG1fSUR0k=
X-Gm-Gg: AYBFou3tGDiC3UsOHkTqKv5uNn5JmBZ7A7eJrbakFykKSSvoSQy8lZBPw2Y8KUgqkpQ
	uiW0L7hSRnPPQIVj7OlobcYQsYJxsgcb+nY1+2HRvkzzmeRuBJcoQQ4dGBGkq0Xsz5KgTkSw/rc
	mpxc1RMg/s8ujPxggRh9x8oDP+cG8sVEPA5E7QRRkVwsZWtoo711nrvlZr8L7LMdvYex7xDNsu6
	s4QORPOVbBp7s6H0vD891o1VgYVTPo5daOKXKLeihEqjawj4EuF1tOsNgKJFqUG2mViVNekuVaa
	EHjPNkLfeL4bHZF2iYZb4RIzWkjjLhMXiGTF44aJgz6nV0Ph514LhN84YMPX0AnOj6eUmX60gCC
	hedu7ajSZUT3iMMZS83M0lxT+3AlCDQ9jMncm6M1MFhCvL4vZyINArMjLvOXWHJaf9FwOLdfjk5
	W1QHovTcTSCqqMthGglBjkLBo2GAtWNuP0ipmoDXXkSbrMe7rULEoxFV2r04Ma8OmtGYTwVS6Kn
	mfpOp87dSAgOs5fFdt61PzyllzD5HKxi185ZxbatC/AVft41tw1O5iGKNEaKU/pEs3aD9uL96IR
	XuFvFQrfQT3S0WmE4w==
X-Received: by 2002:a05:622a:8b08:b0:535:d7e:dbe with SMTP id d75a77b69052e-53fcbee4226mr9184971cf.12.1793135390022;
        Tue, 27 Oct 2026 14:09:50 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53838cf2dbfsm88162341cf.2.2026.10.27.14.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:09:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 21:09:29 +0000
Subject: [PATCH 03/10] xfs: set SB_I_OVL_USE_SYNC_FS
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-ovl-containerized-sync-v1-3-802e512379a6@toxicpanda.com>
References: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
In-Reply-To: <20261027-b4-ovl-containerized-sync-v1-0-802e512379a6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
 David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793135381; l=709;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=1Z5502S4N9+PxpDJ24MamzJyZyNagTbtfNLwpblShXA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDJutvjNlSBU/eOcQ9wQNaWwYhbQ0y1uFYtQSeQkyDonWymvy92FRNAyiqlerkJRJJxNhvaXRz7
 8R+gU7AP+DQw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

All metadata is logged, xfs_fs_sync_fs() forces the log, and there is no
->write_inode().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a06132aa384..2f09d48b7e6f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1924,7 +1924,7 @@ xfs_fs_fill_super(
 		sb->s_time_max = XFS_LEGACY_TIME_MAX;
 	}
 	trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
-	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM | SB_I_OVL_USE_SYNC_FS;
 
 	set_posix_acl_flag(sb);
 

-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787984;
	b=GhFsCKMVKB+5lPEfmGBihXOXghqAVOTlck1bwzHlhawOc7RKa74Ftqm9StP45ykEyUth
	 T3lCftuSMfPLpAXvIknkbrP30nB6aZHbHVRPDohpN8bIW0KyUXayfzhiJkpe04kx2a0hu
	 XxnrIyu4lkezF6qhIgtAndsbG7ClsMNqj0lLihbEXzk4mpPvMrsgfyksRVU/+HtqiM1zC
	 HOvpHWkTG/ZBqbh5FGEgwl+r38gEMLxRkEX8pbbnu/pKnmSVWruAsh614O+JlxmEvZ5V1
	 ZRM9eOBBTeoD8OIRPFIWz/JzMjo4hkxIIbGEQAgHRSWTIVrybbWuhybYKL+scmgLe2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=KhND9XCVrKbJO7l5U95EeteiXITb1wWmDS23m7xhTi0=;
	b=Imkkm+SZUAamFFy205dtWPklmFIrQOK5JoBQC8g/HLDATQeaj9QJkK+L87GIQSH3b2hN
	 kcmp3xX8Lvwxsbj0VbTxohO7ygpUfm2Ybtw3n5owT0reXmo4sSeH7QkEVgCNzHoWMoWHp
	 71y0ZJIqHeueorGCEIpDIOuuzXm64Mp3Aq2DEUnJRzTYLFWH9q0gqFIWPhgcjbd6bgdfC
	 VUGj4LZNiZ3CNu8yXGe9rjb2vFcg/00qmciiTvSLaVgcgbDePInyiogdBWsYe1rsO7f1p
	 2ah371+xSa7B+1IVs3AKGW0vXG4A0C5FXQoOFQzCkUElPPsxh9vqh5gK2ProV58krTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=OzIhFCBm;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8C606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=OzIhFCBm
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535179e995bso12094901cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792787983; x=1793392783; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KhND9XCVrKbJO7l5U95EeteiXITb1wWmDS23m7xhTi0=;
        b=OzIhFCBmkPmKHSJwGDGMgQRUzaDT4NdbdTFNtN4HE7MDhQ5LcbgngmnLbBHA5bu02J
         ASwMSHEU+6TB7d8O+0NUmarDvdnNxn4D+0qH7reK64frGGpp6mowr/eKztkjY48M7wDX
         LJzrDxxR1QlWibuyhHnJpzPh6CyKNbWyMYgKfVmlUh9CB9BsIO9+6Ls9MgGHo8zs2dXb
         rhGF0iA7FnZ2uDyI6vgbcD4n+MGm6OWXLV+toJlpj1/xvw3M9wH6LfC24bT7F+KNIiP+
         aZ12GsjJdqu8rcgAjvWszla6AhHlw6di6b2Hq0FgkyesjGMwkKYLfHcce9b2z9AZV1Gm
         ZvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787983; x=1793392783;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KhND9XCVrKbJO7l5U95EeteiXITb1wWmDS23m7xhTi0=;
        b=zuXjOF+uSG0zf/m+wmtpFfRo0vN1eu/uq1CuNzcVeOxVEe8RiqAwWGWhIfxoKrturS
         nwnRA0ll8M3r0GpGgsH8sM3wK8DzqpMUJOQnsI0kWNuwIY80AS6uYlyw+7hzO/CRfmLY
         hrMOiAJrj9uoD/h7W6sv3d+d7rJUfcdi1rwvl2sriGF2ekHn1cPEpQqWSGKD88F/xp86
         /bC6NP+VlRKFoejIF013cYhTMDkC8LBjxsZfyiLKzSxna8FlXolT3HAv5a0a22DQ1jWy
         TwnhtyiWri3qmSENFm52V093QcNSb6y8FhKagn5pQm6EebP/hXeA4MDOovqXfRd009nb
         ga6g==
X-Gm-Message-State: AFq9FYKQXiAWbl7xkNLzDkw1axREANxikaDnE+YsSAK7oYf+Rq/QpTM4
	wzmW87eLwKA1Lw3nGPDaekja77rHoQXgngIOqkfFG5qd/Jsmd8z/uch1279g3SjKlTQ=
X-Gm-Gg: AYBFou0jQFZ21b0OAWpM4YdajGv0DDltMeuO7iFDUpM7ATGnb00G5uI7w/eBxQHgDrK
	ukgFE9nbdzs0W2Srrm+DhdQDgkkgE1kLOwQYQgLy2JutNigIfibltAmBwUjjCbN3wuPmePfeOxe
	Qu3K5S8nFdoHWB7wnlEj5HSbLYbZAk2wXOxGdhdbHWlHpcXMmhA3FOmLoHnr71q12OAg8uwJYns
	S7wqHfbM/XxHbBgVcoDJpuGN/mfU0UVHcr6JUwC7Hob8xhG4rNR3BRsRkUVcKiJYblMIY4U6hgZ
	azzlKcT+JcpGPX+PhUJsls+9VijZ+QZTBwcXox7nB1kejDa/p/7t2BnLBN94+/d9t4YqHvsnpJM
	NF6Yv/Tz4VVrLN91wzXDk9JVOVzn2BVnf0IT82Tl3LTFirGEOpBrN5WoAgXQcoVXSYSTS87wZjS
	dC4Bg3LwaUHmBDiluB1e/0W6mrNI37rO4YVgWd+JMFvJFCEx9pYbeOH3MIuwI+7hL5SgnwR7cx2
	G7Fte1S2eosz3hCh+92tekimqR8wtMnjFESndqf25yNA5MxHN+xG7r6Eiff4tV6X0MGnjq+vHQP
	ZQPLOVTcDN38hzWLZA==
X-Received: by 2002:a05:622a:4d94:b0:536:7081:7a29 with SMTP id d75a77b69052e-5383b66e1dfmr424651cf.38.1792787983152;
        Fri, 23 Oct 2026 13:39:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c129b2sm3956406d6.20.2026.10.23.13.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:39:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] fs: make the system calls waiting for s_umount
 killable
Date: Fri, 23 Oct 2026 20:39:29 +0000
Message-Id: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAALG22oC/2XMwQ6CMAzG8VchPdsIg2D0VYyHdRapzkFWZkwI7
 +6mR4+/pt9/BeUorHCqVoj8EpUpZDS7Ctxow41RrtlgatM3tTFIHSqm55TCgg/x3pJn7FzfHo7
 EruUB8nSOPMj7mz1fftZEd3ZLaZUPsspI0QY3llPh/q8L2/YBJDljmKEAAAA=
X-Change-ID: 20261022-b4-s-umount-killable-4c6379bec3ef
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792787980; l=3136;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=/dLZyRvsjzBsxEbK5wijtc/SFtt+GpiR7lyMhHxfx1M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHgd+vD1/3+15vhG0gtj7hgV33Mv/fMWlgyUoU+SIy8Bx5l0Fl1HdpMPjaa14tVJI3aG5OaQel0
 AXt9LTWQJGQo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

This is the next step after the stuck unmount and stuck mount series,
and it applies on top of them (vfs-7.5.super).

Those two took care of the two ends of a super block's life, this one is
about a live one. s_umount can be held for a very long time. syncfs()
holds it shared for as long as it takes to write the file system out,
and on a slow or dead device that's forever. That by itself doesn't keep
other readers out, but as soon as somebody wants the lock exclusively, a
remount for example, that writer queues up, and every reader that comes
after it queues up behind the writer. None of them can be killed.

This converts the system calls that take s_umount themselves: syncfs(),
quotactl_fd(), mount() with MS_REMOUNT, fsconfig() with
FSCONFIG_CMD_RECONFIGURE and umount() of the root. They all take the
lock early and can already fail, so a killed wait just turns into an
error return. There are two things that happen before the lock.
quotactl_fd() has write access to the mount by then and drops it on the
way out, and a forced umount() of the root has called ->umount_begin(),
same as when the remount fails today. Killing the queued writer also
lets the readers behind it go.

This doesn't touch the super_lock() helpers. The walkers, sync(),
drop_caches and friends, have the same problem on a live super block,
but I'll do those once Christian's rework of the helpers is in.

It also doesn't make syncfs() killable once it has the lock, it still
waits for writeback uninterruptibly. That's a bigger job.

For testing I put ext4 on a dm-linear device, dirtied 64M, suspended the
device underneath it and called syncfs(), which leaves it sitting in
sync_filesystem() with s_umount held shared. Then I queued a remount
behind it. Without the series another syncfs(), quotactl_fd() and a bind
remount all pile up behind that remount, fsconfig() reconfigure, turning
quota off and umount() of the root pile up as well, and none of them,
the remount included, reacts to SIGKILL. With it they all go away on
SIGKILL, and once the queued remount is killed a new reader gets the
lock right away while the first syncfs() is still stuck. On both kernels
the syncfs() finishes once the device is resumed and all the data is
there, and nothing hangs in 200 rounds of all of them running against
each other. This was with KASAN and lockdep on, neither had anything to
say.

fstests on ext4, xfs and btrfs gives the same results with and without
the series. Thanks,

Josef

---
Josef Bacik (5):
      fs: make syncfs(2) killable on s_umount
      quota: make quotactl_fd(2) killable on s_umount
      fs: make mount(2) remounts killable on s_umount
      fs: make FSCONFIG_CMD_RECONFIGURE killable on s_umount
      fs: make umount(2) of the root killable on s_umount

 fs/fsopen.c      |  8 +++++---
 fs/namespace.c   | 13 +++++++++----
 fs/quota/quota.c |  8 +++++---
 fs/sync.c        |  4 +++-
 4 files changed, 22 insertions(+), 11 deletions(-)
---
base-commit: e6d8f4efc8e2301e15de7bcf9e8d3a2134fb058a
change-id: 20261022-b4-s-umount-killable-4c6379bec3ef


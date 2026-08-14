Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB473C1F54
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708019; cv=none; b=kvGr1eKSjGeeJPF7QiBXfGbZ77PRWDWwMgdoXy98IcicI0g4kfyU0PumWojboZv0taw/2NIzCvMQ15Nq45rrFeWTDufNt9FL5ScZkdCnDpmfqN2a28I5c2WZAgU4Y8HMxQ6gGxyHsNLJdbQHFwdp7On89dYji3e2tZsToHMSi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708019; c=relaxed/simple;
	bh=Q0XcrHSJ3QTrQ8yuePARUprN0VBhGZwly3clupHqqiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdC7cGDqm8qgKezASDEs/BRcEWgX3UN3/YV9E0dCjldJiTP8jE4i9BSxA20ELnrl5mqf+EioA0I0MgSgrQv/dcwWSeIVCzXW9pJ4EYIPei1+IzGDTjRJRDiISBxtphwagPNxi4uLbn4vDiHcqUPvZ/HmGVa8OXdQ+Yb9vf6g2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMz5m1oI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMz5m1oI"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso817991b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708017; x=1787312817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfQhQO+zY2Dyxo+r+2sLRmPLM1j/TIfku35TJ5q2hrU=;
        b=WMz5m1oIdrV+ry1nOMxSE6mfW+eFACEFB+l4IL1QGHpKdZfp2Ix7JAxHlqsz3pvk5w
         xnLiB0iSp4ipXSq8VlpxdhVoZ1xRSbAFrkNKrFyGUsab5yJsWEWzdAOYqxvLkp2JNq+J
         oaJTXCVsNg1TCtwADBImAxQwxB8Vj30rED2dQ4jWi/gv2szZYt3vuGOw78q0actxGBFm
         RZT2eSHVLTA8J4gY4ANFeTXylW2ZASKNPMo7EhCXHXpU2v20ccNhiLcsz0AnFogNz8Eg
         Kao6UNK+cj6GGIw3usSHDrOm7aOiCfSK3QWuc0H/VuJjpIbM6Uvlk7JL8ASxITxYurtM
         lsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708017; x=1787312817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfQhQO+zY2Dyxo+r+2sLRmPLM1j/TIfku35TJ5q2hrU=;
        b=k0hz35NNcog41YD/KXM4NZEPLv52Ft2SONOFmpFWATL7Ppd1XrBgwV38RqhJKAw8Um
         8v1xtxEk/+x6jv3l105phgKgtPQ1Xjr/eOHZLBI1akXlQpfrwxlxlFKXhqMBmLCsZKVB
         ir2T8CdNLmf0BX2RtCETp0yuTaTyY9C++K0yoh5k+RWZd85irzOyUg1JR1zVPPBedWXh
         iZRSIQIZ09UayvM02IeMpC0a0Q9oFlh3R/eM1Y9DympYJ6WmCHWBf89agzYu5tdEvzIv
         4w1RVli50JAHKkc4WdQxnyzUiijH8hQZusstJ1hRut0Lo6IlR1vOQadL7dGt+0fVSf3D
         zeiw==
X-Gm-Message-State: AOJu0YxXi/5O9h7q0ezSPp1wkbWg21ImDS3MENEWmfUt+EFbjgnWyQbm
	wM6l8OkWf1ZfzJ5KBFUPM7Ej+oHZWM3BZn/qlNP6+D6ZIcIvRy9rdvF5
X-Gm-Gg: AR+sD11Lg8SDl7nyIELmanGYPqBJ60cs+e1byEBvEjLKGTLTO4Z5bxcwj6nGUFqH78u
	wicYH6u2x8KUgDtETZNuwQrPrrYFpcwpJEU51HB826bGmTel1sIqINKxj+wnuiHZiN6bvJqK57r
	igLfkbrGdgtxEx7+36TMl2h9pK87jI4ZRrkhc/1zC53TVv9x5I/GijGNimSieUEUyu1n285T4Be
	GgHMw6q0IW9Xy23fwBzLTi51ro+ILTCyFMl4tbtLWsghXpuV13FbYSX1p48DIwLb+Fx8vUl4mRk
	XhdANrV26Jx0vaqOh0WcAd7hi7rzCdGaDJxi5WKQzAcg7kfmrP+SWdWOrQWEYq9HsG/vSH42qkP
	pkIyLVqZVIGsdZVTBQ6CwY/cXmJ5Z+seef1lG2TlnSg8nQ3NLpqpZ7UGabPq3Qf87wb0NSCa6MX
	f0RQ50eoxhksZejnUFKfVNGwGokyeOJ2Zoh2KGvOJycL0l/3+PZN1DkN0bmhf5gLd8/ahxa/b/8
	5opp5Onn17icoOq93QMawFA8Q==
X-Received: by 2002:a05:6a00:2384:b0:84a:32ba:a262 with SMTP id d2e1a72fcca58-84fc7a2d32fmr12157562b3a.7.1786708016944;
        Fri, 14 Aug 2026 04:46:56 -0700 (PDT)
Received: from localhost.localdomain ([219.251.253.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223e4bsm339450b3a.30.2026.08.14.04.46.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 04:46:56 -0700 (PDT)
From: Kitae Yoo <kitaeyoo777@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kitae Yoo <kitaeyoo777@gmail.com>
Subject: [RFC PATCH 0/2] quota: opt-in strict enforcement of project quota hard limits
Date: Fri, 14 Aug 2026 20:46:47 +0900
Message-ID: <20260814114649.51253-1-kitaeyoo777@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ignore_hardlimit() exempts CAP_SYS_RESOURCE holders from enforcement of
hard limits (and of soft limits past their grace time), regardless of
quota type, so it also covers project quotas.

For user/group quotas this matches the long-standing expectation that an
administrator can act on a full filesystem. For project quotas it is a
poor fit: a project limit bounds the size of a directory tree rather than
restricting a user, and is commonly used for capacity isolation of
container volumes and NFS-exported shares. There the exemption defeats
the purpose. Two concrete cases:

 1. A process holding CAP_SYS_RESOURCE (e.g. a privileged container)
    writes past a project hard limit; accounting keeps rising above it.

 2. knfsd raises CAP_SYS_RESOURCE for requests mapped to root on
    no_root_squash exports (CAP_NFSD_SET in <linux/capability.h>). So on
    an ext4-backed, no_root_squash NFS export any remote root write
    bypasses project hard limits, no matter how confined the client is.
    We hit this while evaluating ext4 project quotas for multi-tenant NFS
    volumes: with a 2 GiB hard limit, remote root writes proceeded well
    past 2 GiB (v6.8, quotaon reporting "enforced"). The same setup on
    XFS, whose enforcement path performs no capability check, stops the
    write at the limit.

DQF_ROOT_SQUASH already disables this exemption, but setting it has been
confined to the old v1 quota format, and commit ca6cb0918e87 ("quota:
Verify flags passed to Q_SETINFO") later made Q_SETINFO reject it
explicitly on other formats, on the grounds that those formats did not
persist the flag and a flag silently lost on remount is confusing. That
confinement predates generic project quota support (commit 847aac644e92
"vfs: Add general support to enforce project quota limits").

This series lifts the restriction and addresses the persistence concern
that motivated it:

  1/2 allows DQF_ROOT_SQUASH to be set through Q_SETINFO on all formats,
      so it can be enabled per quota type (e.g. project only).
  2/2 persists the flag in the v2 on-disk dqi_flags field, which already
      exists, masking on read so only the supported flag is honoured -
      which also keeps the pre-existing unvalidated on-disk bits (the
      reason c119c5b9749e "quota: Don't store flags for v2 quota format"
      stopped storing them) out of the in-memory state.

No behaviour change by default: the flag stays clear unless explicitly
set, and setting it on a non-v1 format previously returned -EINVAL.
Accepting it there is the user-visible ABI change 1/2 makes.

Open questions for reviewers:

 * Is extending DQF_ROOT_SQUASH the right vehicle? Despite its name it
   has always controlled the CAP_SYS_RESOURCE exemption in the generic
   dquot path, not UID squashing, so the semantic already matches. The
   alternative is a newly named per-type flag, at the cost of new uAPI.
   I lean toward reusing the existing flag but defer to your preference;
   the uAPI comment is updated to describe the real semantic either way.

 * Is persisting the flag in the v2 dqi_flags field (2/2) acceptable? An
   older kernel rewriting quota info still clears it, so strict
   enforcement would need to be set up again after booting such a kernel.

 * The NFS case is really a knfsd credential question (should
   no_root_squash grant CAP_SYS_RESOURCE?). Fixing it in quota covers the
   privileged-container case too and needs no per-export policy, which is
   why I bring it here rather than to the nfsd maintainers, but I'm happy
   to pursue that side there if preferred.

Reproducer (ext4, as root on a scratch device $DEV):

  mkfs.ext4 -qF -O project,quota -E quotatype=prjquota $DEV
  mount -o prjquota $DEV /mnt
  mkdir /mnt/vol && chattr +P -p 42 /mnt/vol
  setquota -P 42 0 $((100*1024)) 0 0 /mnt      # 100 MiB project hard limit

  # root write, flag clear: exceeds the limit (the bug)
  dd if=/dev/zero of=/mnt/vol/f bs=1M count=200 oflag=direct
  du -m /mnt/vol/f        # ~200

  ./set_rsquash /mnt      # Q_SETINFO(PRJQUOTA, DQF_ROOT_SQUASH); no CLI for this
  rm /mnt/vol/f
  dd if=/dev/zero of=/mnt/vol/f bs=1M count=200 oflag=direct
  du -m /mnt/vol/f        # ~100, now enforced

  # 2/2: the flag survives a remount
  umount /mnt && mount -o prjquota $DEV /mnt
  dd if=/dev/zero of=/mnt/vol/g bs=1M count=200 oflag=direct
  du -m /mnt/vol/g        # ~100

On XFS the first write already stops at 100 MiB. set_rsquash.c:

  #include <sys/quota.h>
  #include <linux/quota.h>
  int main(int argc, char **argv)
  {
          struct if_dqinfo info;
          if (quotactl(QCMD(Q_GETINFO, PRJQUOTA), argv[1], 0, (void *)&info))
                  return 1;
          info.dqi_flags |= DQF_ROOT_SQUASH;
          info.dqi_valid = IIF_FLAGS;
          return quotactl(QCMD(Q_SETINFO, PRJQUOTA), argv[1], 0, (void *)&info)
                         ? 1 : 0;
  }

I can turn the enforcement check into an fstest.

Kitae Yoo (2):
  quota: allow DQF_ROOT_SQUASH on all quota formats
  quota_v2: persist DQF_ROOT_SQUASH

 fs/quota/dquot.c           | 8 +-------
 fs/quota/quota_v2.c        | 6 ++----
 include/uapi/linux/quota.h | 2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.50.1 (Apple Git-155)


Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47414334A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535511; cv=pass; b=Vbvkd5rlFhh1TWNEaEB3MNad+XsGW6Rp3npNlm1QeMf4/Yhmpp58EPnmSf454Ta6oXsrLoviNHCdih0+6K8GT7OYIr9Ca2/HtJlfll+5AQlIj/KrWprfdJ2+W5pec6MsGzScm2fD5eSS/INmTFannLOiKtzXsKyPgfQ2382Sx+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535511; c=relaxed/simple;
	bh=uolDTwf2YiR9pwirmH3u47bV7dskx1o30vxi3dsH1yA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jd2kKlUH8lPgQMQ3P3r9ktTthM9/Tc4qd1XVPLVt0zo1RO7QvxxLhxuQh/9DtQXsIu3T4XjMHXZdXm5LbUBzP04MSr7wWUZRZktG75h2RrJHe1PhTExnix1nKEwcxs5wE+CBUOdYBZodbYF6RiQvsOIPOyBSgSPSHrMH+2WDQR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo/7zMhg; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo/7zMhg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8111c0c7561so8891817b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 04:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786535507; cv=none;
        d=google.com; s=arc-20260327;
        b=muIFODIW8RGtLU//9Oke4Ed5QxOvS2r0vRuPOD12fGbKtPevllObV0WGlmFXTC3dza
         zdQ/vLA9TKZhCSNi42bldrrU6lbBnOAn2CQ6hpkv5si6W4wZqH3YoM7sxX2+Mo/4EZZd
         DALL4cl0emsfaZtkkIBaVmYs1iVmrYkgUaHVF6gfxg2yjn+FDrLxgSt41rANfHn+JN2c
         z4XCu6qfnMZFmhdQHIxRfd//a57hY8kF9zsxlZH/CbmSL0BXTcodZLLuQWDeM56ginr0
         Ctev5vy1EuqAQ72N8DGyv5tV1TOb6cVPDLUDzaCdrIZ75Qu8amPl4A51MdD/JkYwnooY
         3C7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uolDTwf2YiR9pwirmH3u47bV7dskx1o30vxi3dsH1yA=;
        fh=zWNg94ESO0lzGy2I36JSxQZbp4N7T8pzSNeVcucFp6U=;
        b=EwxoxCAocSh8Ts1BK27HN3cR0H8MPoQd3H4Vo3KBPjdhsaZFsFXNQYTUHF8qlgvszD
         huYY5CZmI7JoIEZwCsjduGe8SBdlyud/1RSoB1EQZJ1+2oMhCH72zvwSe402zvXIMBoL
         dv7Lr1zGE/mPk7WRdGQAsn0aWsUPtqEDhPLwxfSHI0MQ+15la23UJOtHuCushhu91DbN
         MxvW1B7nGiIPGYk4BToF9Nvdfbb5mzTH5ucRUT8fQ8V22zv+W8ndj09RA3XygyX3HYcY
         DCGXrcOBhXAHupua/kCMy7uq8CnGhWW6ORfEfFvpGYU8b1AF2OOPI0AhboLBwGGBcKQo
         7SXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786535507; x=1787140307; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uolDTwf2YiR9pwirmH3u47bV7dskx1o30vxi3dsH1yA=;
        b=Fo/7zMhgk565qXGrrgCJ0UjpnM7Nu1msm4IxM3w8Qq9gObfF9OfJ8VkQlobgJnCgEZ
         YMuQRY0+5WvTFqjwEYdQ3R5T8/EjKq8qrx2t4t4tOBV3FFQVIDRBZuasnkdDHi62LZRB
         AbYurRSzi8siJOpR5qMieqVmu84H1odP9rl2NEvMaYixEdgkrtlIwZXhyThGcx1KXZnd
         AM0Fk4LNtNXlTmIawRSjbZhKcw/w3dP6wib09hUEMKIFq62yfVhDgaUGzfUmRHxnlpsn
         U/R/2PyIyfJfrTjB9ix4kN1wCYvnBYPkKEPtsQwA57kMYfwAhb4nhmlOYpTljrSxtM+f
         a08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786535507; x=1787140307;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uolDTwf2YiR9pwirmH3u47bV7dskx1o30vxi3dsH1yA=;
        b=c2fMGweQg5bjThVKi9pSO4JPioCRGaUr17P326ux+4oNLaoxJfedy/3pjntEzak/hR
         kEvrji0asbA/XCeLiLG/wD87mdDjWqYJmbISydhIaN6lUaAH1rcjhBQJGb2bQV3lC4Kz
         qV0TdVRNVgcRLmh+EuWrGTrAmmt6TsDfejXMRGX5c2HsPNOVSh0+s7ZDbDTf/3CTlLsf
         VkNPBOu0Lp1HSgB5h2/Ol/9FdysRjhiA6pRgSX22QQBjiRRn/hhwJtCvKlW2GzAWBRzr
         qMr9Wgztxs/ZyI83T+l0z/WbCaaXNMAACW+8YLVKY3NNW6Am8zGyqRMHM/PxMye+beQZ
         r3Sw==
X-Gm-Message-State: AOJu0Yxp5UtaMI7gmAjmC+gzkunCZRN6EyY5SEQxiu7wezCLt0y37uNo
	2MzeMwhIQ6bSHdLDZfQywYe63Xxc/QlcZcf1g9frzwluypvVWg7sHYVfg1AS/sg+nZPtzsXMWDr
	iuYLKhEnvH49qd0+wRWOD25vSdmdNVzJfqrFL
X-Gm-Gg: AR+sD12jKz9UdKUNBNCjWdw6uqtuKWvEw+gaJvBDkkNurkbMO07H4TSwJb/omZHRsKN
	YgdT8YoorS4m1eSAXL2+zolY8ZiycwWOYtkYxkzZ/JHra+8e2eolXPKDqfRV1b07fFDBG3dXRxj
	+1xUYQuawgtK6vjDUOBcf/F8395MgslR5m4UADkdUCXF55i9B9R+Ly4nS/zTmbGqTxnavlODAAU
	qd/5XnkQ9gh1oZImVan/Jx7lNkM0vtCldU2VTlxSNAg8vYFi5zMnMbb+pADwzhAM1nlTHDHRWvn
	Rsmr+yEZSmpvFfOirGm6V4KzImYSEWC/IcvY8L6W0g==
X-Received: by 2002:a05:690c:6612:b0:81e:8ccc:cd59 with SMTP id
 00721157ae682-83108b88099mr22263907b3.22.1786535507276; Wed, 12 Aug 2026
 04:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Harsh Upadhayay <harshupadhayay906@gmail.com>
Date: Wed, 12 Aug 2026 20:51:36 +0900
X-Gm-Features: AUfX_mwwW0gBWGwomSE5vd_A82nDw7ASN34mNPUMg9_1_GWbkI_2wf-_xdU_i28
Message-ID: <CAA5ehdZpfp2w6SWjGm3K7rs-F9Fj-jBY1pRqu_zDbnan2X3U9w@mail.gmail.com>
Subject: [RFC PATCH] fsnotify: raise default fs.inotify.max_user_instances now
 that memcg accounts for it
To: linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	longman@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

I hit this running a 3-node k3s homelab cluster: every container on a
node shares one 128-slot fs.inotify.max_user_instances pool (no user
namespace remapping), kubelet alone was holding 25-40+ instances just
from ConfigMap/Secret volume watching, and the pool emptied under
normal load -- surfaced as an unhelpful, inotify-silent "too many open
files" in whichever container's turn it was to ask next. Filing as
RFC since I couldn't find prior discussion of raising this default.

---

fs.inotify.max_user_instances has been a flat 128 since inotify's
introduction in 2005. That number is not per-container or per-workload
-- it is a single pool shared by every process running under a given
real UID on the host. On a multi-tenant Linux box, that means every
container's root process shares one 128-slot pool with every other
unremapped container's root, plus the host's own kubelet/containerd
(or equivalent) bookkeeping, since user-namespace UID remapping is
off by default in essentially every mainstream container runtime.

In practice this pool empties well before 128 "real" watchers are
running, because kubelet alone routinely holds 25-40+ instances on a
modestly loaded node just from tracking projected ConfigMap/Secret
volumes, before any application container asks for one. Once the pool
is empty, the next process on the node to call inotify_init() anywhere
gets EMFILE, surfaced by most userspace libraries as a generic "too
many open files" -- with no mention of inotify at all, making the
underlying cause hard to diagnose from the error text alone.

This is not a new observation. It has been independently hit and
worked around downstream, at the deployment-tooling layer rather than
the kernel default, at least by:
- Red Hat/OpenStack (dnsmasq-per-subnet exhausting the pool at scale;
fixed only in tripleo-heat-templates, defaulting to 1024) [1]
- NixOS containers (~20 containers sufficient to exhaust it) [2]
- Docker, which raises its own daemon default to 8192 [3]

Two ways to address this at the source were considered:

(A) Scale max_user_instances with available memory, mirroring the
formula already used for max_user_watches (1% of addressable
memory, clamped to [8192, 1048576], added in commit 928901237497
("inotify: Increase default inotify.max_user_watches limit to
1048576")). This keeps the two related limits symmetric and
self-tuning across wildly different machine sizes.

(B) Simply raise the static default, on the grounds that the
original justification for a low global ceiling -- guarding
against a single runaway process exhausting kernel memory via
unbounded inotify_init() calls -- has been substantially
addressed since commit ac7b79fd190b ("inotify, memcg: account
inotify instances to kmemcg", merged in 5.12), which charges
each instance's kernel memory to the creating process's memcg.
On any kernel >= 5.12, a workload already confined by a memory
cgroup (true of essentially every Kubernetes pod with resource
limits set) is already bounded by its own memory ceiling, not
by the global instance count. The global number no longer needs
to double as the primary abuse guard it was designed to be in
2005.

I'd lean towards (B): it's the smaller change, requires no new logic,
and leans entirely on a containment mechanism the kernel already
ships. It also has multi-year production precedent: Red Hat's
OpenStack fix has run with max_user_instances=1024 in production
environments since 2017 [1] without reported ill effects, and each
instance's fixed kernel-memory cost means the absolute increase (128
-> 1024 instances) is negligible even on small/embedded systems.

(A) remains a reasonable alternative or follow-up if maintainers would
rather keep instances and watches symmetric and self-tuning rather
than static -- happy to prepare that version instead if preferred.

Proposed diff, fs/notify/inotify/inotify_user.c, inotify_user_setup()
(current line 855 as of v6.x master):

- init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
+ init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 1024;

[1] https://www.google.com/url?q=https://bugzilla.redhat.com/show_bug.cgi?id%3D1508030&source=gmail&ust=1786621798113000&sa=E
[2] https://www.google.com/url?q=https://github.com/NixOS/nixpkgs/issues/36214&source=gmail&ust=1786621798113000&sa=E
[3] Docker daemon default, inotify.max_user_instances=8192

Signed-off-by: Harsh Upadhayay <harshupadhayay906@gmail.com>

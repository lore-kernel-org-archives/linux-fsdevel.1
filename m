Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CC1E0DE8;
	Sun, 11 Oct 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791732656; cv=none; b=b/dsIsjdpgaRNpvRwCoW40aHxypLzMSVLcP9DWauvn1qlpwz73TPH2XhCjruquUCKf2+F/eUCNJ4rs4nX9/Xlz8rLGzyBunN/a3J/hBCeoXU4CTuOLnQlA3ikdVvtPp7+JCcFzPrqQPFCpjRQZ79GSKxw7sLjm7LTeFI0oo+sMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791732656; c=relaxed/simple;
	bh=CwrG87X9sj4fhkPEgn/AWj/sslue6xMrvs5a61YJ/VU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gaLfd8hwNdv6DmlEUi9txcTLZBqF3447NWAy7HaM4YV0x5OdvYEQyBzzb0ersbmq8q2lcSkx69BiSQ3i1rATAzqPdzTuavbhDV8xZohHmzEt9zVZAxau1ifDg8qbsfZapYHLg3WiMbz+0lTMVabnI1/N2A6rLqIGbzJv3G2udvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGu3SnPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGu3SnPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631051F0089B;
	Sun, 11 Oct 2026 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791732655;
	bh=FMRX6OPRT4SNHqUhNNRMMMq+x02FPXL5OtrehYtbEsU=;
	h=From:Subject:Date:To:Cc;
	b=EGu3SnPytG2rfRkpdoj/eKqouZPLPrHnuhGQ8stkJwLn/vZ7tRnCmCfVBgyRvKToh
	 HwzH82IXRBi13XmeqyvictrgxkjDeNwDU0hYc35KSARziV3ZmiXLwN/PWpg4NSqDDc
	 iydfOJsvaUPKYDDsbFCFRMJDibwXg7UiFmqxkDDlZx5Cr/u63vm5lOsASsQqbc5eRm
	 1Ne+ACrc2o9z1lL8WYLIgtCOkG3qAOpKVacexlik9hqOs8tO6AOhldl/ZrBEAwYl3R
	 14aO4Djc4ay6RN7xsfZ4ByifSFkU5ZPOc/IOmGesu4CZvKzLbBo1Yir5P662BlzP6n
	 35P8rRnWF658A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] fs: drop the smp_mb()s that mnt_get_count() made
 redundant
Date: Sun, 11 Oct 2026 17:30:43 +0200
Message-Id: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9LM2iFAKAuvYlwATi0awTBtNWl6d
 wGXb+a/twNTicRwHnYotEWOOVVQpwHC7NKdMN4qg5baKqkUfnJ54iuvacEpfolxRGeslsaaSSk
 LVXwX6q/qXa5/5tU/KCyt1BbeMaEvLoW5nVpT9KboohhFW8Bx/ADCX4MKoAAAAA==
X-Change-ID: 20261011-work-mount-fixes-5-a4620464f116
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 lkmm@lists.linux.dev, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CwrG87X9sj4fhkPEgn/AWj/sslue6xMrvs5a61YJ/VU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdXr26JKFpX3Kk8b2LXcXyjlu4VuhN9LC6z6+/2Wfi2
 WrTt7t3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk23OG/3kNmVwxh9/sZ12e
 87huj4V3q8v6mPU+31d9sjkkvcE1x52R4QnDCcfVF8TzL3DP+Lu1f37Y8cOC4rXSjvyXSx5dtbt
 XxwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

mntput_no_expire_slowpath() and do_umount() both have an smp_mb()
between taking mount_lock and summing up the reference count. They pair
with the smp_mb() in __legitimize_mnt(). The walker increments the count
and then re-reads the seqcount. The unmounter writes the seqcount when
it takes mount_lock and then sums up the count. They must not both miss
each other's store. That's store buffering and it needs a full barrier
on both sides.

Since 7eb84d54fac5 ("fs: don't let a migrating task hide its reference
from do_umount()"), which is in mainline now, mnt_get_count() has an
smp_mb() between summing up the puts and the gets. In program order it
sits after the seqcount write and before the loads of the gets. That's
the barrier the walker needs. The outer ones don't order anything on
top of it that anyone relies on. So drop them.

I ran into this while getting rid of the grace period in
namespace_unlock(). It doesn't depend on that work so I'm sending it on
its own.

A reproducer can't exercise this. So the second patch adds two litmus
tests under Documentation/litmus-tests/fs/, one for the slow path and
one for the busy check in do_umount(). Both are "Never" with herd7
against tools/memory-model. Without the smp_mb() in mnt_get_count() or
without the walker's smp_mb() they are "Sometimes". They're "Never"
under Arm's AArch64 model and the POWER model as well and klitmus7 on
x86 in a VM didn't see the bad outcome in about 2.1 million runs each.
All of it is in

    https://github.com/brauner/linux-formal
    kernel/work.mount.gp_on_demand.proposal/litmus/

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      fs: drop the smp_mb()s that mnt_get_count() made redundant
      Documentation/litmus-tests: add the mnt_get_count() barrier tests

 Documentation/litmus-tests/README                  | 20 +++++
 .../fs/mnt-slowpath-sum-no-outer-mb.litmus         | 85 ++++++++++++++++++++++
 .../fs/mnt-umount-busy-sum-no-outer-mb.litmus      | 83 +++++++++++++++++++++
 fs/namespace.c                                     | 14 ++--
 4 files changed, 194 insertions(+), 8 deletions(-)
---
base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
change-id: 20261011-work-mount-fixes-5-a4620464f116


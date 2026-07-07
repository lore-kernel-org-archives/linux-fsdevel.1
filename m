Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E937B002;
	Tue,  7 Jul 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436751; cv=none; b=iGbImPV8I6XwOIXgdiKXBSLwpATFsf0JxoIeC5jKU5aTdXI3nd1p0PZAypm5todpSRyWJGJXIPa4YtCAs4rdIR+/LVhwcf3e9L9Gj45OuXxkCePl6nViRsDSSqdenBMJLyx2wBIqWCsqqHheqJft8PXvKkx1FS9cHaTgc4A1EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436751; c=relaxed/simple;
	bh=lnW4o1LEWaTuVDAaJIbYEVzGBrPOHGqFb/UZ7P7fm2s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s+S9iQ/1D3wLf1fiPW2jAEy5E8wAZ9Rc5MWddcnBPxHc6aG83mM+DFWAOVoyYkatowDvn+7nNFZdunwHQKKAN1SpRxzOrSq3moKkG9tNafi9tmN7CLeFlaalM1Z7r72gIuT3dcfA3+oau5d5oXOF9A1TbOEfUO99YDrlcnm14lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nZdQz/5U; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nZdQz/5U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=C8BsyrwlkEt1WOmkUAqlD9OydmnL5eS/Y/dRrBSBbuc=; b=nZdQz/5Uxcl+WCinM6KlZuAM6E
	EEFf5gt/76rq6TxxYUb9S/67jRFXkOvEuZUd8I5oMVntSrcU+ItuIoSusCzsmIGytCeBTsR8hh8kM
	GtWSmHuWnJZ/Hmm7whzoGveCamlbYteOOIcTCARv0yAvF/YGkdrldhYNh1fdq6Nu+bvkXscAg3eeS
	Al+vVw1LStEvZ3Ks05OE037TmS+IXa/ny0B3Aog6pdDSUz16nmnNsYwnHhYeCnLxJXW9LzPJ3ltMi
	Ti+yLfk8vFPtJuKhd2/hkULgISnGEbFKMp/Oa9TzOt2+Jkhpq9nuvaT/ccUtqf5Wd3ooEsAliQSnO
	mQPA0sXw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh7Mk-002Gsf-2C;
	Tue, 07 Jul 2026 15:05:43 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Date: Tue, 07 Jul 2026 08:04:57 -0700
Message-Id: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoVTWoC/23NsQ6CMBCA4VdpbuZMOaU1TLyHYWjpAbe0pEWiI
 by7kcTN9R++f4fCWbhAq3bIvEmRFKFVVCkYZhcnRgnQKiBNRhtq0N9wkYXxGWWUwa2SIjrvrL8
 31AS2UClYMo/yOtVHXymYpawpv8/JVn/rzzN/va1GjYGuozO+ZibbBfbi4iXlCfrjOD4OCN5Ft
 wAAAA==
X-Change-ID: 20260625-b4-pipe-unification-aba7b8525de7
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, oleg@redhat.com, mjguzik@gmail.com, 
 josh@joshtriplett.org, Jan Kara <jack@suse.cz>, jlayton@kernel.org
Cc: axboe@kernel.dk, shakeel.butt@linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925; i=leitao@debian.org;
 h=from:subject:message-id; bh=lnW4o1LEWaTuVDAaJIbYEVzGBrPOHGqFb/UZ7P7fm2s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTRXC3xRavpmr831T5I94cAIz9Cufc7/hVuIFG
 N9BDCEFEW6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak0VwgAKCRA1o5Of/Hh3
 bU+eEACPuKSjXKvpAz3FkuyLd9QszRew+QBBaAGbwFCGlefXssk+k/0j1rjoCE5X0vHqy+tnc1L
 6YXd952e3o19d8glKUrhdgIsnfnY/rBuLLKLhRaBhlUATwT4Z18uEWU/ev3U5kGp04mwSIJhWpO
 5cho26AQ3i8TQ1QETJPjs8aaBgqRKEiJNmUTQQwyBIiJmTwsve4QMu+Q/gK1O9wMks8AJqdi0Mc
 BXpMiKsFj+bejUErvRtBjFwVnR5CFC1hvovQlfqn7K7JmSMC5RRPdFLnRVtPF7T2BDj5oKcNBb+
 kIeiHdRx5VGXQx/hwW+4UJp3ZURVGuDg7vFiNo1VuZiibiAbStc/YYui1WAIqM2Bs9Gg8ANfi9S
 BFha6EENxOLgEg6xa+sWd36PHHVCake55BYtKOQrDIkE1Rz/1d6M8x61FeBHNoQbgTBFJgr2v8w
 v/Zc7vXvKYHjiEo8GrhhM8le2uyovpEUsZu29SNYJC4ms9ZVkTxxbNML6RMfNvPjf7ir0XZ+0ep
 VeK/f6ZZphDaKkRCR6Y0WX1hbY3sxuNhL0r5qWp5DavhfnyThghRmqBuaMWnE5eCGe8pp9uHhO+
 eddFlLwxFfXZ+hGQuIxzXk1vf+GYs6k29Dg3lwleFmholcrwsoSAgK2UKM+t4I68z8czZhkCk6e
 83Kgaj1y0rDsJRg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

TL;DR: This simplifies the pipe code, unify the page pools, reduce the
code by 9 lines (not counting comments), and no regressions are seen in
terms of performance.

Summary:
=======

I've spent some time converging tmp_page[] and the on-stack
anon_pipe_prealloc pool of pages into a single per-pipe pool, as
discussed previously in a few places, most recently at:

https://lore.kernel.org/all/ajLA_zxsYyKISkwp@redhat.com/

Problem:
========

1) We have two types of page caches in the pipe mechanism today
   * tmp_page[]
   * anon_pipe_prealloc

2) they operate in different ways:
   * tmp_page[] is protected by the pipe lock
    *  per-pipe, persistent, 2 pages
   * anon_pipe_prealloc is an on-stack pool, not lock protected
    *  burst, up to 8 pages

Proposal/Design:
================

1) Keep the same page budget as today
  a) up to two per-pipe persistent pages
  b) burst of up to 8 pages

2) no pages are allocated unless necessary
   * Pages are _ONLY_ allocated based on the length of the write,
     minus the pages already available in the pool.
   * No page is allocated but left unused

3) keep allocation and freeing outside of the lock
   * only the assignment of pages stays lock-protected
   * Currently, tmp_page[] pages are allocated in the lock, so
     this patch will improve it (thus the performance numbers)

How:
====

1) replace tmp_page[] with anon_pipe_prealloc in pipe_inode_info
2) at write (anon_pipe_write), allocate the pages outside the lock in a helper
   called anon_pipe_prefill()
   a) the assignment into the pool must be lock protected
      * anon_pipe_prefill() does it
   b) anon_pipe_prefill() can populate up to PIPE_PREALLOC_MAX pages in the
      pool
3) once anon_pipe_write is done, the pool is trimmed back to at most
   PIPE_PREALLOC_KEEP (2) pages by anon_pipe_trim_pool()

Future:
=======

Once this lands, we could keep all allocated pages in the pool and rely
on a shrinker to trim it under memory pressure.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- User READ_ONCE to read prealloc.count
- Trim the pool at the reader side
- Link to v1: https://lore.kernel.org/r/20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org

---
Breno Leitao (4):
      fs/pipe: move the prealloc pool to per-pipe infrastructure
      fs/pipe: add per-pipe pool push, prefill and trim helpers
      fs/pipe: switch the read and write paths to the per-pipe pool
      fs/pipe: remove the old on-stack prealloc helpers and tmp_page[2]

 fs/pipe.c                 | 169 ++++++++++++++++++++--------------------------
 include/linux/pipe_fs_i.h |  21 +++++-
 2 files changed, 94 insertions(+), 96 deletions(-)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-b4-pipe-unification-aba7b8525de7

Best regards,
--  
Breno Leitao <leitao@debian.org>


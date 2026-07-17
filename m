Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072620E6E2;
	Fri, 17 Jul 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309252; cv=none; b=OMCp7fvUkmrBjQ2rzZqErnbl7NeIGVu0B/RtiogbIVGH7w94UtNG8hNMbyamsAhmrc+uBVxjTmwJwr/ViPSdQjVAAwn8pMV+Ze3jGGnkH+f7RSSnognZqSXCnKnhT4Wv/2gTz4sZe/IXXz+GZILHgOxdoZrxnDQJka435NsRagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309252; c=relaxed/simple;
	bh=5qOAkI5geB9c2QJT+ZJuYGTf9tB6cnyrWqqOZSHtdhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f/K9p59A43hZ1RZNCDTWRy2uojgq0mFxjHxA1QCOpwlVb28mHqxP/Rt1EUbFW7daJle4uP0dxF7LkPwBzK0RgnkyjbS0PBFf8NTKvElmXQPc4BHDhigVTfqYlYQcKtO1sqnjbgjCDY4715VJOkZZSEUN4UPTQtEtRZFm0byrl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCAnQTOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCAnQTOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BAF1F000E9;
	Fri, 17 Jul 2026 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309250;
	bh=0O48kuedeadPtyYVMr3HodljE4FFFuatXpDbwuYN/VM=;
	h=From:Subject:Date:To:Cc;
	b=jCAnQTOrXc2yVCktE2fgCOUK5EpwHMMV6r+iIgfurcC4h/YjtIDoVFGYgNfEzmcqI
	 5zuiF3d3pzNYXfUsMvPmxTE6FqFAfyjUiAJF623VdMsQCkvvXRRUHnbjEMC+r4pXYS
	 LnbIS/orwSxTC//nhjeWaUo8M+cQKtQLbRVVPRGUKFmkB5e7rMwOAo35uQPeQI/p9L
	 h5Cgy86sO5+1OfgSXLRZltyq5plxJHt+nMOuQ47jXFSOK1WTdPx6181/edxK2ejElu
	 RVzrT+NNzKLZBN2WkwBchnBlNN7vTeuBXjGNb+Mbv6s1T0cVlJKIax/5L0BGwvkq5t
	 jK103XFozxIYw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 0/3] mm/mseal: further cleanups
Date: Fri, 17 Jul 2026 18:27:08 +0100
Message-Id: <20260717-mseal-fixups-v2-0-0daa0014b813@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxlWmoC/3WNyw6CMBREf4XctTV9GExd+R+ERQsXqCIlvUA0p
 P9ui2uXJzNzZgfC4JDgVuwQcHPk/JRAngpoBjP1yFybGCSXJb+Kkr0Izcg6915nYkIJ03KtdIs
 S0mQOmJJDV9U/ptU+sFmyIzcGR4sPn+NvE7n3R70JxpkyuuTadvwi7P2JYcLx7EMPdYzxC562i
 Jq7AAAA
X-Change-ID: 20260716-mseal-fixups-131ad0939de2
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=ljs@kernel.org;
 h=from:subject:message-id; bh=5qOAkI5geB9c2QJT+ZJuYGTf9tB6cnyrWqqOZSHtdhY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKiUj+EWEUlbP0+1Vg9PzH18/bFZY+WbXnNxBkhb6f58
 DO79xeVjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzEL5Hhf42d+QeFPzfXNzwX
 OCbzav4XhxmzD+ycWPsqN/9ejqfpH0VGhkYvs2ZpxW13aw3bdETFBUOjKhYtZJx8Xd5uo1aE97K
 nzAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The mseal implementation is still rather confusing, so tighten things up a
little.

The only user of do_mseal() outside of the system call is the MMAP_PAGE_ZERO
process personality - retain better control over how mseal is utilised by
providing mseal_mmap_page_zero() for this instead.

The comments are overly long and confusion, so cut them down so they're a lot
clearer.

Remove confusing mm_struct params (mseal can not be used on remote mm's) and
wrap the actual system call logic into the system call declaration.

---
v2:
* Added tags (thanks everyone!)
* Abstracted mm as per David.
* Renamed [__]mseal() to [__]mseal_range() as per Pedro.
* Moved to reverse xmas tree declarations.
* Tweaked commit message for 2/3.

v1:
https://patch.msgid.link/20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Jann Horn <jannh@google.com>
To: Pedro Falcato <pfalcato@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Kees Cook <kees@kernel.org>
To: David Hildenbrand <david@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
Cc: ljs@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

---
Lorenzo Stoakes (ARM) (3):
      mm/mseal: remove superfluous comments, fix confusion around mm
      mm/mseal: limit scope of mseal address zero to address zero
      mm/mseal: remove further superfluous comments, do_mseal()

 fs/binfmt_elf.c    |   7 +--
 include/linux/mm.h |   8 +--
 mm/mseal.c         | 160 ++++++++++++++++++-----------------------------------
 3 files changed, 58 insertions(+), 117 deletions(-)
---
base-commit: 59c684a9908d2e6f7a791f7f033eae57ec2b3a61
change-id: 20260716-mseal-fixups-131ad0939de2

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>


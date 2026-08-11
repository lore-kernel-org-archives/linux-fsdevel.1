Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB033264F2;
	Tue, 11 Aug 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462055; cv=none; b=nQHvrr9PtkiSuiLZbIJSutsM3EBjdbLLXwliumMptVXvznYP2O/xWYyNTlbPjdYff8JFcMv/q7iWrboTMq7Pj9f+vdPnu1kc4WnbwHzHaeAbGUVWC2ZbrF7A27OhvGuE23qUalzowTvXZHuNGYo9xbyroF3DJox9jWvph3fXqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462055; c=relaxed/simple;
	bh=1qHewHSXRcdYAaTnKKH0DpOw8nUTqXZkj+4XBvqR5C4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I0io21ZkueCp4y/dYzLOvl0jm4596LSDh2ttucoIonnI20XTDz0akVHcbIuF5cfWqsxA8gHmJ00HpCsZLnWWdDMHbv0dKlfIFN3Sq87QWD7Hj78hIzslC0PTrPVV+dRIGXC/jx85SRyN/yoGB4u6tS9BD2HHeGUWxtDqh4BWeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqvJN4ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqvJN4ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A0A1F00A3A;
	Tue, 11 Aug 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462053;
	bh=HXGN+7DyTtsXASE0Xx28luC/PppdvwQ35E4XsIfnroc=;
	h=From:Subject:Date:To:Cc;
	b=BqvJN4ji64/oOUX2EnFxNXoqg04JhEpnBQGw7xNGN/zaJ6XI7PzMBraz1NrQt4yei
	 Wqs4cFR6qerGTXMd5Sl3NjxJP6DVtKt3L2drI5dNGT6sKmockwGav3TsqzD5zfG0i1
	 pOuJTrklYtOlicbTYnaTrPnILV97BUuQQ81UsCGfHY6hf5VIAauNQxUWaH9NhlbVdy
	 O1whZE0cOKO5nqaUPYTim1r2guugrjHj8iXkC+zJoJ+gZ6pfI0ucHsdZgppDz22tTp
	 eymEsMKyBTlRFLlEKN9QhrZjxxIjhHyKzfcr8SqbRRkHTXbn9yhlqmExwQaHMGe4G5
	 9MYqnDaRuXoSg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/11] coredump: allow to create sparse coredumps on the
 coredump socket
Date: Tue, 11 Aug 2026 17:27:21 +0200
Message-Id: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2kCmSFP8FXGRx2ijNAkzrQql/
 95El+dyz9lAiCMJXLoNmN5RYk4V8NSBn2x6kIqhMvS6H/SIqD6ZX8pnprDORUmxLKRwRGOCMU7
 jGapamO7x+8teb3+W1T3JL63VHs5WzbFNfmrTbGUhhn0/AKCEPsaRAAAA
X-Change-ID: 20260811-work-coredump-sparse-18177d77b014
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3673; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1qHewHSXRcdYAaTnKKH0DpOw8nUTqXZkj+4XBvqR5C4=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGp7P2CiEcw1DU7Ai+OgN8p+lfwbbW0AppufWk6kpoYW9p9mB
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmp7P2AACgkQkcYbwGV43KIvmAEA2Wze
 c/m0aNRh0crwsw6YxvxsZTHxQzCmK/dONsndyYwBALLT9S+a/xY66rac/QOOGQOPaYYQImDpZ45
 gTngmFv4P
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A coredump generated via the coredump socket ends up transferring
zeroed data when a mapping contains holes. For a large process that
maps a bunch of data that's wasting a ton of work.

Jacob ran into this and Josef has bitched^wcomplained about this to me
before. I dislike the coredump_filter bit solution in [1] which stops
each PT_LOAD at the last populated page.

The problem is real though. I don't think coredump_filter is where we
need to solve this. That mask says which kinds of memory to include and
it propagates across fork and exec, whereas what is being selected here
is an encoding mechanism.

I also think that the usermodehelper - may it swiftly die - isn't really
salvagable for this and it's not the future anyway. The coredump socket
already has a handshake for stuff like this.

I always had an idea how this would look like but punted on it back
then. So here it is.

A server that raises COREDUMP_HEADER in coredump_ack->mask doesn't get
the coredump as a plain byte stream but as a sequence of frames. Each
one a struct coredump_frame_header followed by what it describes. A data
frame carries its bytes. If a server also raises COREDUMP_SPARSE, zero
frames are sent for unpopulated mappings. They only indicate how many
zero bytes need to be written and to not include data. Reassembling the
frames gives back the same coredump. A debugger and everything else
still see an ordinary core file and nothing outside the coredump server
has to learn anything.

Numbers from the selftest in patch 11, on a kernel built from this
series:

- a process with 128 threads: 1740014 bytes on the socket for a
  coredump of 1075150848 bytes
- a 256MB mapping with one page touched: 170542 bytes on the socket for
  a coredump of 268890112 bytes
- the same 256MB mapping with COREDUMP_HEADER alone: 270993024 bytes on
  the socket, so the framing overhead itself is under one percent

The first one is the interesting case. Almost all of it is thread stacks.
All stacks are 8MB reservations that are nearly all holes. And they are
holes in the middle of the dump rather than at the end.

Link: https://lore.kernel.org/all/20260731171336.2255844-1-jalalonde@meta.com [1]

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (11):
      selftests/coredump: discard the right amount after the coredump request
      selftests/coredump: collapse the expected request check into the helper
      coredump: pin the protocol struct sizes
      coredump: move the negotiated mask into struct coredump_params
      coredump: deduplicate the to_skip flush
      coredump: add COREDUMP_HEADER to the coredump socket protocol
      coredump: add COREDUMP_SPARSE to the coredump socket protocol
      tools: sync coredump.h header
      coredump: frame the coredump when COREDUMP_HEADER is negotiated
      coredump: describe the holes when COREDUMP_SPARSE is negotiated
      selftests/coredump: test COREDUMP_HEADER and COREDUMP_SPARSE

 fs/coredump.c                                      | 178 +++++++--
 include/linux/coredump.h                           |   7 +
 include/uapi/linux/coredump.h                      |  65 +++-
 tools/include/uapi/linux/coredump.h                |  65 +++-
 .../coredump/coredump_socket_protocol_test.c       | 415 +++++++++++++++++++--
 tools/testing/selftests/coredump/coredump_test.h   |   9 +-
 .../selftests/coredump/coredump_test_helpers.c     | 200 +++++++++-
 7 files changed, 849 insertions(+), 90 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260811-work-coredump-sparse-18177d77b014


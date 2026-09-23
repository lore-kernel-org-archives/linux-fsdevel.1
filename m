Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58978446058
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155436; cv=pass; b=TpBO1/NCfv8+8eOvpJs5UTuIgvXYPK5QK3Isinl92iIe5Pfoh7q3ZIJns6owfAxEJmKT4lsg3KlTIDZ8F59aZR3PwNvrBXJlK1x+z9XJVDMBJWR/Z4BBrWgw25EknBhrMYkrqVCEmyyNSJ4nOIMl1Pad0zb57y6bJF7IVyOkN0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155436; c=relaxed/simple;
	bh=3xEe9ZWG4AtCEMdKNW95DX462BuG6lSlRZEFAMmAnec=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rQdg3tN+/9dKXK7V1DalRwWPdw5VzxsABYGjaIocxW+0tNE1Z2d6LwYXdKN8oQOrWMyzvNFHGXjAxjnShlN8N4VSWMZu2jbTKTZl7TAZedSHvbI1Nwe1mOa+b2vPAGjG5LEc9jvD4aWtp3QoFa6pfZB6aMjF+5nX2csIqvXfyrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0nAVcGU; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0nAVcGU"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso1131618a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 02:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790155432; cv=none;
        d=google.com; s=arc-20260327;
        b=fPxdLsAAMbOwm5IgCCpCYukbJwng4Mi31Y+Gn0F2vEk3SugwBbu8Pcpp2uq0aDD/tJ
         fYBY+KnQphDe58K+smn6u7XIEF1tZS//EIn0ehoVJpf78VF7zZ+hpgetTwYV9wqc0y6n
         nJf25vKAS6ervkq0wd6oddsSLISaIQaGHL/p1RpCdh3Exc5EUUi+W4vplQQE59ZwxK0T
         0yxiV1+h9YRO1Txs4LlyVDsGn7FNhxaaGNkweWv1nf8uG/BljqLQg36qQsU4951HGzf/
         toWBsmAfKwRVvgrBdv1Ruq5zBPfXFz+DcGeNaiUZJpG8x14uHzi4pAhqQ9TFGUNX6J11
         4N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2hLXCXGrUFIrTUGKCgEPiNvPtQcPtRp2BpI6S34RUXI=;
        fh=PvHWx0W3nfQGtiLl2C9AAZqNtJoAGG5hn7TSBl64fY0=;
        b=p4HZblMiwyaz5sysXzhTBcK/cd3FqbiuDxTRPae2GIdQ4h6rHQgIAnTpI6bk2dxOgL
         S+wsD7Y+ImQe1pjLcLBhpY9DyePlB4mTtzlYIwpvspmIfxceWdFyN6flBlLJYHeOuy6E
         agCNR4u6VHtFAGrGvtnS/yqkJ5xQcvqPzOXbxIHep+H3TYjKiprqGMTeJchS+mJLiLY0
         9N30n41CrVGR3+5mK0XqZsvw4kikclKDKTlgL5tonXBgL2J+Q5PLnwjv0LTLkr2QTS2/
         30ohJpTccmx8dLZinHSe7n7RS9oVAsUbAgTQQujXvPOh1oYQjvfJvXUarCDGo7R3PFZg
         iLow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790155432; x=1790760232; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hLXCXGrUFIrTUGKCgEPiNvPtQcPtRp2BpI6S34RUXI=;
        b=J0nAVcGULjFq4qAdfxQ3m5RUmUTZSzdYydTu2KHnXFogGHVoJHg8NaK+6N6JrBSmuZ
         aRbrI0QA05nN/Okp7cnETAYnLcLfGdWZqgwjtpCmKzX7ODCEb5/gTse4JJG8TcACBhcG
         G6+XbSiid2uUj0CGTw5L7sReJdUd03wPEuPcTnZZcRxfXJwReYjQv0jtG98Y9ohIZ/uO
         69D372QIedDhtpo3Gcdg4ULHBg2QVtQtvyH4zHzPnnqdX1bSgwALbp++ulL1ix2Rolop
         8kgI0D78g11O9/Rfbxv6QluYQN3jUBFIrxOe5oVSU0IvhbLprY/BzFd6A8J3GSzVHQGu
         5B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790155432; x=1790760232;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2hLXCXGrUFIrTUGKCgEPiNvPtQcPtRp2BpI6S34RUXI=;
        b=EgRumIE9ZnLdPs6pt29AwhRq+Xbr8cP3BBTht2d1f87/9cSOYsY97WfcTCgZdAFjMg
         B6mZiuCRcZTZXqktugB/Wf68eruXtlErv9ZvPQW8fRnUZ7d1XQQC1qgWAUgazfOSPupk
         6vaZoefPLRRkQlkrjOmLyEg3dTlkjZQI68Ical1aVXIn3cAorxJakAhOO2O49QNewI4Y
         nON37NegUj4QBkQFZhxZFTz6ViXndveq3jxGeD1PYSGV1p1f6Uv0pEFYlUAloy6RUR6a
         bK2Xi9JGYsUZrVHKi6WnbUm54NX2pjR/QRbcmttBxa+Kc45foKGhnPZyVt8A7Q0ZnRrM
         TlUw==
X-Forwarded-Encrypted: i=1; AKwUvBwFjS3clEuCN7NQst2vTxZXAyxCVOv9gvLdYdk0DQAmB+A2kvnmjV6nBFrZF/d5ua9EyudDiVOMeMEi3kGM@vger.kernel.org
X-Gm-Message-State: AFuF++l9H63N4ctcfMAkvik9+y+w24tr5Rq2+awnu+aww1des8e7Rsd/
	KLbZf9QI0uPA+ig3MxBf0PzPcYJIyayfK9Wticw3VHy6mTAPUmXqhoxLe7naALFH8grzH8cv9l2
	9RAQm001IBJVnAVcWTWgQEHXgudPGGxI=
X-Gm-Gg: AYBFou0by65fqFr2xxHI6Zr6BXyWKGj3KS8uAKgi0tkyi4zVN6nZGbBb5Y9vlgMmogt
	OqKqAccbRwXPHGW3VsU+GCdvWsUxZC54iD3ReSS1cCG8FA3toDUVoa/zKqCblgTWvX7JA4fhZK/
	8O3ryiNS1S06tomYi1JHpGEkHlyuw+rpvAfbfOkV4aiXBW4DaidunvTZJxSFT3OCllUtVu5YqjW
	cyenRvasmwjgSGPN5IN4fO/C43c75KARvfqc2s1LASTynkmFkdzG84TAcIHTjRX5X5SsDeuuHUs
	YefmgciZa5841gy+gU84at9hp+69MM4k/wjxFxK6bnaReco6Z5tVJtcf
X-Received: by 2002:a05:6402:2547:b0:6a7:fa18:3a47 with SMTP id
 4fb4d7f45d1cf-6aab3b05d24mr1797571a12.12.1790155432351; Wed, 23 Sep 2026
 02:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mitar <mmitar@gmail.com>
Date: Wed, 23 Sep 2026 11:23:40 +0200
X-Gm-Features: AclHuK_XsSSnSwpJLnw4jYOz28Ykgi_x6JWCChZzbweTHAhiQ07yDfXaHqqbXVI
Message-ID: <CAKLmikMHpPdXmyPMPhad=wc_HerzCv3wEtp4s-E+NrjvuHj3pA@mail.gmail.com>
Subject: [RFC] fuse: temporarily detaching a passthrough backing file
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

I am writing a FUSE filesystem which stages what a command writes in
layers, so that the changes can be reviewed before they land on disk,
and I have been looking at whether FUSE_PASSTHROUGH can serve its data
path.  It cannot, and the reason seems general enough to ask about
here rather than work around locally.

Once FOPEN_PASSTHROUGH has been granted for an open file, the server
cannot take it back.  FUSE_DEV_IOC_BACKING_CLOSE removes the id from
fc->backing_files_map and drops one reference (fuse_backing_close() in
fs/fuse/backing.c), while each open file keeps the reference it took
in fuse_passthrough_open(), released only when the file is closed.
None of the FUSE_NOTIFY_* messages reach it.  Granting passthrough is
therefore a promise that the backing file stays the correct target for
the entire life of every descriptor which gets it.

There are two situations where a server cannot make that promise.

1) Quiescing, to make a consistent copy.  A server which snapshots,
backs up, or tiers the files it serves needs, at an instant of its
choosing, to stop writes reaching the backing file so that it can copy
it, and then let them continue.  With passthrough the server is not in
the write path, so its copy is torn; fsync does not help, since it
flushes rather than stops writers, and the only remaining option is to
freeze the whole workload from outside the filesystem, with the cgroup
freezer or similar.

2) Re-targeting.  The file which ought to receive writes changes while
descriptors are open: a cache evicting or promoting a file, or a
stacking filesystem redirecting writes to a new layer.

Of the two, (1) seems the more general, and it is the one which does
not depend on any particular stacking design.

What both would need is a way for the server to detach the backing
from the open files holding it, letting io fall back to ordinary
requests, and later to attach a backing again, either the same id or
another one.

The io path looks mechanically simple, because it re-dispatches on
every call: fuse_file_write_iter() reads ff->passthrough per write, so
clearing it would send the next write through the connection.  What I
cannot judge is the rest.  fuse_file_passthrough() is a plain read of
ff->passthrough, so a detach would need something to serialise against
io already in flight, and the io mode transitions in fs/fuse/iomode.c
would have to be driven in both directions: out of uncached io mode on
detach, and back into it on attach, with the page cache invalidated in
between.  The kernel does already perform one such transition at
runtime by itself, when the first mmap of a FOPEN_DIRECT_IO file
enters caching io mode.

mmap is the part I expect to be contentious.  A mapping is bound once:
backing_file_mmap() sets the vma's file and then runs the backing
filesystem's own ->mmap, so the vma ends up with that filesystem's
vm_ops and page tables into its address space, and nothing in the
fault
or writeback path consults the fuse file again.  A detach which
covered only the io path would therefore leave existing mappings
writing to the backing file.

For (1) that is a bounded loss: only a process which mapped that file
MAP_SHARED for writing can still store into it during the copy, so the
copy of that one file may be inconsistent while every other file gets
a clean cut.  overlayfs documents a comparable deviation, in
"Non-standard
behavior" (b) of Documentation/filesystems/overlayfs.rst, where a
lower-layer file mapped MAP_SHARED does not see later changes.  For
(2) it is worse, since the mapping goes on writing to a file which
nothing resolves to any more.

So my questions are:

 - Is an interface of this kind of interest at all, or is "a backing
is forever" meant to be part of the contract, in which case it would
be worth saying so in fuse-passthrough.rst?

 - If it is of interest, would a detach which explicitly does not
affect existing mappings be acceptable, documented the way overlayfs
documents its deviation?  Or would mappings have to be handled, by
walking the backing inode's i_mmap, zapping and re-pointing the vmas,
for such an interface to be considered at all?

 - What shape would be preferred: an ioctl beside
FUSE_DEV_IOC_BACKING_OPEN and _CLOSE taking a backing_id, a
FUSE_NOTIFY_* message on the connection, or something keyed by nodeid
rather than by backing_id?

 - Is there an existing way to get either of the two behaviours which
I have missed?

Code references checked against 7.3-rc5.


Mitar

-- 
https://mitar.tnode.com/
https://noc.social/@mitar
https://bsky.app/profile/mitar.bsky.social

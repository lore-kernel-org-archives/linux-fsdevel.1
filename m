Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664A37F33A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648926; cv=none; b=hA2FRg1dB4sT5M9pRsgdWI8zHlrSRZeEnOyr7K8lao7wqo2YollaUiJegqSBdBrcLKInIJtW/ANgssmJR7X31EkvBKF7AnxrJ1hc31wqZFNhyPMCAf8j6BpKmhJ10dzCJUy4PsmWTKcsefRgGYlvRePfTFLW0PuuMPmVd2SWHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648926; c=relaxed/simple;
	bh=GmL6uYTyqVpHWhqeQHdsU9G6vcZFB8HJbWZWZuDYhJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1SvBn+yhzPKdVmwUzvedfz/SRB8Q9hxJ72hwXHO4/huJQCOSIom+qIrtA/ZE7+rrQwCDyEokPlZxCW/LFuPkuBx8IiGG1XJ8UseTvM7BFLTtXB5h8YFU/vi4HbhH0d+yzzq7khMRf06aJO/a64yXvmrk2zFLKdTrXY8DD0iQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VygE6DQQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VygE6DQQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c214321dc32so874264366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 02:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648923; x=1788253723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmL6uYTyqVpHWhqeQHdsU9G6vcZFB8HJbWZWZuDYhJA=;
        b=VygE6DQQ9HhaANCBSOycBdWktAe735FJyD+F5MiDqzlbLXo4rJxV6q2IGnTyH5zBvg
         7rIBDyJgh8t3alhAzxP05a/QCksiG2sr+WJbYQxZW2qTwEll62eD8gMtTNWlSGo6Iyg4
         BjFO2hGC42YJKvXIUiqGO9HlO5h0MrHfdyvyRHce3iFtfOXx+JSsKJrs4G6q2K2pnrd7
         PVDjxv7eFbm26M0Qjwj0+qDJ7xqhPiLYmQWVcJATRwLWkYA8QaQfRcvelK+nc5HEWESx
         38uvWVU6uMl2mzo9O6fnRYpzF/tqKgjIXjz06l/k05aiwgYI56SO2LESCGoAi/TLt544
         jw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648923; x=1788253723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmL6uYTyqVpHWhqeQHdsU9G6vcZFB8HJbWZWZuDYhJA=;
        b=BPefhiViWXli64jK3tTddVmXkiCTmiu0Z9jl0gtidzQKHCNBDN/neNcG6fCEQcVKV1
         HLY1pxHBLAWyCRI207eTTVAzwlneQOVhSdNiBr7WCHS9EusMdXSlBtky7sPKEnXF4f6E
         +S79ZepYYbiGopYG2jQIZKKBonNhwgZNOzfbwMmU+LgRIAOuXQkFkDb3S8sD+gfUyPLa
         1lhtRCrvaSz7Bh30PFQ9IHvSJFsPcldsmmEwiJeKlO6cP1iSOE7wjm/8dz5gnxn2KZYj
         D9gEB8cb/FJ/rY0tL+nSnEFHVasJJwl/P79pvt1utz59M+WT+v1ra6BQHVvSJWKm4uc4
         O5Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpktkfUzs01cryIOCDWYZzjzp24n4F6D3L9AOdcV5VxJYAyZ6ml+yW1ZXrVnOGkWhBY3VX1Pjpvw/F2Jwwb@vger.kernel.org
X-Gm-Message-State: AFuF++kdKzwFNrlcj7thyCgSazlx72wohhtlqp6a5WKRqkheEtulkhjD
	Mpnwg91T+oun1FLmiVcCABCAU78TeyE5ZmV70BMlLbVhyyv+I9r3UIw8
X-Gm-Gg: AR+sD125wb8dFgVZwgd+GrllntYbdyCWPhpssf5zGijCbUfD5fWKta9iU336wRZkSPx
	dvK06DZvo3aky8RqbJlKrzzQapWiySjFHChbakySfz183RXer3nvNzttGS/hMBNnSj8cDgSt6A0
	pP6wGUzM6Ajx4o+/XYHoLo6kR9h/y+CgLq2qkwpe0rzMHeCvfnciJk+7HfWepoUxB5wu72tFTgp
	7tk/uHYlqrDdTndL+Y5w/LSBU5ym3jIOaa+g6M4H0GkTAsPJQ+twC3hL0VZlcs/9R1zRXrF+6Vj
	+lUCMFjGZ1cZiYd94CqnIZd0oVKWoXhEIdhWlChMCWij+I9rwD5eH0kWJ1Xbgw+Sauw5zxxAu1X
	7uh/F9MsTQg5H2b3MXm/up0bGg9JXpz/ReKYELLvpjdNph6bI4wo1zBE4Z+R6GdmlfY1/h7ok/A
	0OkeyNuQGpsjitkX++2Givw3vYSbdGnNXJXiDZrvRN1DuC7PsqMTzcmPvca5w2I6Dh2Phd4rAYE
	1fxVCM3ptBqMWLaahgqhzTPcJtpWEmc6MI9BWbp2RIodoHzTgSk
X-Received: by 2002:a17:907:3e16:b0:c16:3074:657f with SMTP id a640c23a62f3a-c246a4ce3b8mr3646590466b.9.1787648922702;
        Tue, 25 Aug 2026 02:08:42 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-2.dynamic.spd-mgts.ru. [46.138.191.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59dd550bcsm13565742a12.0.2026.08.25.02.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:08:42 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Ackerley Tng <ackerleytng@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting arbitrarily large entries
Date: Tue, 25 Aug 2026 12:08:27 +0300
Message-ID: <20260825090827.64550-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b682a12f-ac03-4032-851a-f4f7ced4ffa0@kernel.org>
References: <20251117224701.1279139-1-ackerleytng@google.com> <20260824194755.216000-1-iprintercanon@gmail.com> <aoyqIBz1EoY0R8qw@casper.infradead.org> <b682a12f-ac03-4032-851a-f4f7ced4ffa0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 25, 2026 at 10:31:34AM +0200, David Hildenbrand (Arm) wrote:
> > IOW is this driven by a real need, or just some completionist thing?
>
> I heard some use cases using 512M THPs on arm64 to back VMs, but it's mostly
> anon pages, and not really ordinary pagecache.

No real need on my side. I took the pagemap.h comment and the selftest
skips as an invitation, and the one 64K user I can find on the list
(Meta, in Kiryl's collapse RFC) says mTHP is what they want. Dropping
the arm64 angle.

> But a buddy-like split is clearly preferable. (or avoiding splitting in the
> first place :) )

That path exists as xas_try_split(). What's left is the uniform split to
order 0 that __folio_split() still does through xas_split_alloc(), and
the only one asking for it past order 11 is guest_memfd. That's
Ackerley's call; if he wants the rebase I'll do the mechanical part.

Artem

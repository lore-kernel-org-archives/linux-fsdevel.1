Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CD3542F8
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138647; cv=none; b=Z22Gm/8tUnYyZ+9DfRLxMUht9oC7hJsdreZfBmhP0P5yUhRu8JNuIv8kzCIXAD8WpX2rxZiGr8fkG+n7DmdK2aAg48E9x4ciLpHAxrjfkUJakKywX8H9cx6BVBfHp8M1NByyh24MCqVkIUSRPC4+g3YVEW7JcDSLOuEvWCK+8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138647; c=relaxed/simple;
	bh=1bnKdLsqxeHJCmFKuy98rueTrCsBK/5lWfY8BtISw1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlygO9VV/qgrrpJ0p1BGes3CqKcM0nq/T2TMxyx6xdJHoW44jsws8tuwSJ5baLcmVSOfwKqL0SLXvjPhrGZZTvbvJ6Y3zi3nCKHlRPyeLQwC3xVHyMnUB9qhwN54sxYAxcwlZMZobJ6XSbiTH6PSOd0D2y22HxSLcM0p+MDfIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V0j7sj0q; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V0j7sj0q"
Received: from macsyma.thunk.org (pool-108-26-156-127.bstnma.fios.verizon.net [108.26.156.127])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 68BEusEA023912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 10:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1789138617; bh=aOLqMnhLxFcuZQU5MjIuT6M+r5m+kGO8dRpT+arVVBk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=V0j7sj0qoGJXIVCOxj0EapqMi4j8HuO81h2kbjnaUsZ2R6AUOa/4Xgf6sepue9QlF
	 RhQ+bSGMxs3DUesIlWY8UJxjZ+MhVkPy/EFjnvGmGnqE4/UpzoUjn0hRqAu4KWoZY+
	 jOjNT+At/iIN4tZkrqX9dciXhqdUp5hay57CQ06XsQrfc8Rn9/8g3i1vboEDMuZYZ8
	 e/hACqSoojo+fGIvxPAp78avwE7V9a1nhedhHweL4KUwuNerRKd5avDz+NfHiXilFc
	 cZ0LD2rXI5WurNdh9JsxSLMjOg7BpPBZWsUMh3CFo2TGN5BJlhmn8jEe975fQQZwQB
	 WzyzSlL9m9QTw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E4CD01481C8A; Fri, 11 Sep 2026 10:55:53 -0400 (EDT)
Date: Fri, 11 Sep 2026 10:55:53 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: Re: [PATCH 0/5 v2] fs: Deferred inode reclaim
Message-ID: <aqQV6Uwma_KjUH0O@mit.edu>
References: <20260911081309.14137-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911081309.14137-1-jack@suse.cz>

On Fri, Sep 11, 2026 at 10:51:36AM -0500, Jan Kara wrote:
> 
> after a long pause here is a second revision of my patches implementing
> deferred inode reclaim to deal with MM warnings due to GFP_NOFAIL allocations
> from reclaim paths. This happens because to reclaim some inodes, filesystems
> have to do IO including complex operations using journalling and forward
> progress of these depends on successful memory allocations (which is impossible
> to guarantee from reclaim context).

Thanks for the patch set!  I wonder if it is worthwhile to wait for
inode reclaim before freezing a file system for suspend.  On the plus
side, it leaves the file system in a more cleaned-up state, and
reduces the amount of memory that might need to be written in a
hibernation scenario.  On the other side of the argument there's more
opportunity for freeze/suspend deadlocks, and more complexity.  So
maybe it's not worth it.

What do folks think?

						- Ted

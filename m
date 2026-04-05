Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F532798F8
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775355103; cv=none; b=l0RNu/oX8MiW/BQL/WfaQNk8o+gMM1DMvR20W71csOWyipHT6hxhn/xilBHkOfjUgPQc6siJQJduK4hUeCvyBxF/PfRqUcV4xGoCuhY/vBCgB1YsFwp2nmlJd4Q5gzITpF3PHzAL0YaJ5RvjxYmRb2l7MMFJVXiP9g8Wk6eqZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775355103; c=relaxed/simple;
	bh=zusbk0+1onyGzkWDWyTAhOSfGdl3HyGQN9IIYXakQCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hujqzq7e6ZTiVl+N/oc1xX/Qtd8JDeAcvbFWtyVD1YqrNsQdi2otjM/F8UPjmaGqqut10ErfI4pk6PinPrOav4zqdE8XrQATBe050QMTmS/jM4OLWttb/Qu7yTYVPZ637rTaog20hps6ERUhKL0Y7LSqkoKuhihPe/L7lhwTr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Npey0ZUL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Npey0ZUL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nXaOa8eWIXq5CgHkGsSwUfyd1y6wE+spJxlq5iV/i4g=; b=Npey0ZULSRzHlHcGi/A2EdUjhb
	UFQyzWOnGAw8I5dhNNUo1uLDAgoJEZc6fcteMQeiQhWsWa+3V1oNu75er2Cx6xitTYXujjuIeiINI
	4a0IUUosEqkueCE6CHWxUXr1lUHV4mN2fj5fgBcv2mRtK713Ro1pUwELXN7tb5f5Ycud5btZPRVVs
	0gXbpgMXpVt2a//ocPDHAyTdzoQsLR3c5E8NU1rX7aX2uqBLz/PUcEyjLfclnYcm7JgoF0kzaHYki
	QIzBsYW60QuUD/p7qm4S6m3bQegLgJGRqoxDnD/1ttS+KYSi5EGwmaltGbywvc2xCjJca+TbB1m6F
	EiJZqF/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9D19-0000000C1gP-3dws;
	Sun, 05 Apr 2026 02:15:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Harkes <jaharkes@cs.cmu.edu>
Subject: [PATCH 0/3] coda dcache-related cleanups and fixes
Date: Sun,  5 Apr 2026 03:15:12 +0100
Message-ID: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

1) prior to 2002 coda_revalidate_inode() used make_bad_inode() on
failures; is_bad_inode() checks used to make sense back then.  For
the last 23.5 years they had been dead code; let's take them out...

2) coda ->d_delete() appears to have been hit by somebody overhardened
back in 2021.  Useful tip: if we've just checked d_really_is_negative()
and it had returned false, dentry->d_inode is *NOT* going to be NULL.

3) coda_flag_children() is holding ->d_lock on parent while iterating
through the list of its children; that's fine, but that does not protect
->d_inode of individual children.  Hold rcu_read_lock() over the entire
loop to prevent UAF there...

No preferences regarding the tree these would go through; at the moment
it's in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.coda
but if coda folks prefer to route those through another tree, just say
so.

Individual patches in followups.  Please, review.

Al Viro (3):
  coda: is_bad_inode() is always false there
  sanitize coda_dentry_delete()
  coda_flag_children(): fix a UAF

 fs/coda/cache.c |  2 ++
 fs/coda/dir.c   | 15 +++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

-- 
2.47.3


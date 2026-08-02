Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EF3911A8;
	Sun,  2 Aug 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671163; cv=pass; b=fAIy6K5BN2KcYfmViRfXTS8JUy/xw7jy8Sw9VMjMcQIoSWSj0Qgnh7RkZRYvKkjtzC9vamJhrgH47qEkSojOk4D/p37TFFYA+a/QiiFqc+aTaj3A2YhpJNQMpu73XDcjIYMzxHLZwnKbItwlJ3OrSSDcfGMzTZ1Pkdq4CzYnHbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671163; c=relaxed/simple;
	bh=4guGfp/Co3gWQvQtG7kmgIY9Ih2rg5NQ40NjSyR6KkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrGGyWmQ6X1OCqd5O2qNWelAOIQ1QN51bzgHSjplaCdsr2cFXGjerdtvJ6weFNWhZc59WH+4W4LPK3z2DPxjvLvAGPZ7n+A4GtQQuQkd6nKrAJwUijuQoQ7E91+xWbmEQ7FQQI6UNvpHIbwu5cLGdDejmUtnw35KOT68Yrjz6sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=F8nBQvLo; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="F8nBQvLo"
ARC-Seal: i=1; a=rsa-sha256; t=1785671133; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PLSBop+HHxXf61Om7MxGAsiOdcXopxGXkjOJb4K3U6s7zHJU0WrRfNS1TXruY8AOMKwI/KFwyI+mRxxcGir/p+COwi5GlcDJlSVUnG4lTi2kLaXAoYa6ePE3QSGGQCVzmtCTZc+l4o6GlBBtJHKCwz5k2nhYESs5f90k8XgpHOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785671133; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zFgYURum51diMA1gnu0CQukEqnjLUT5lvpCHu0JeTYM=; 
	b=hdAKbpK1EsCBta1pjsDAHwW7ykGEEeXARIE+SuMYhtqad/iJCB2SIeVX1V1FlfB6bisJIaKsZhW3onFYl+Yi8xFiGqp7sui4VIoEqAchxnPJmrceNGH3kAYQd4CwkOnZAiwOWqpA7aLLN2yQTb+Gfw2RikJ9CynZWTpDBC/ku8E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785671133;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zFgYURum51diMA1gnu0CQukEqnjLUT5lvpCHu0JeTYM=;
	b=F8nBQvLoKF9BF/sDWEpguhZ73l2nkU3HQT/Fpv/EbG+5hQmB9250/NzPRmIMuIdO
	l913EI8zWSxuQAxJuSuOJ3SzZYC3FY1GcKq7x7+jSCSLI/R5ACNmrxAj3CL04Ww/M7t
	GJMSMuYJMfwYoJ9b2y7713m044sflmhsSQdxykTw=
Received: by mx.zoho.eu with SMTPS id 1785671130136418.8178625814943;
	Sun, 2 Aug 2026 13:45:30 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Luis Henriques <luis@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs: free the buffer head container in ubh_bforget
Date: Sun,  2 Aug 2026 11:45:20 +0000
Message-ID: <20260802114520.6800-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <875x1syipu.fsf@orpheu.olymp>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Sun, Aug 02 2026, Luis Henriques wrote:

> But the fix still looks OK.  My original patch also dropped the 'if',
> but that's just a minor detail.

It is not only cosmetic, and your own commit message already gave the
reason: bforget() is a no-op for a NULL buffer head. ubh_brelse() has no
such test either, so dropping it is what actually makes the two functions
match, which is what the changelog claims. v2 is posted with that
changed:

  https://lore.kernel.org/all/20260802114130.6261-1-ali@iusegentoo.com/

That makes v2 the same change as your 2018 patch. If you would rather it
went in under your authorship, say so and I will resend it that way. Your
posting got no replies at all back then, so it stalled rather than being
turned down.

> I don't know who's using this ufs driver these days -- each BSD has
> it's own thing, and it's likely to be risky to mount a filesystem in
> rw mode.

It is risky, and I have been finding out how much. I sent a series
yesterday for cases where fs/ufs mishandles filesystems that are
perfectly valid rather than crafted, among them a short symlink carrying
extended attributes: because the fast symlink test looks at i_blocks
instead of i_size, the link target is taken for a block pointer array,
readlink walks off the device and unlink hands the target bytes to
ufs_free_fragments().

  https://lore.kernel.org/all/20260801225530.148386-1-ali@iusegentoo.com/

So the read-write path could use more attention rather than less, at
least while it is still in the tree and mountable.

If v2 looks right to you, an Acked-by would help it move along. The
diagnosis was yours.

Apologies if this and the v2 reach you twice or late: I took your address
from the 2018 posting and mail to it bounced, so your copies did not go
out with the rest.

Thanks for looking at this after so long.

--
Ali

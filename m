Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A935F162
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171591; cv=none; b=QLFeeDqCv8QKgHG7RCogCxR+q8NQ/p+l5RV36sVQUaFZ2r9OQUiwrfwkwqpoQxpKi3nGBdUCMkgtNEaNaxtoCttgcJdjb4j975+mhTHLTc3sgbxblv2eo5lnXJr7K/a5hwm1tQ89aNE9T4UeswlaKvEgem71GzFmKG7rXd60SnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171591; c=relaxed/simple;
	bh=35kuxh3Yq80kbpbesASh1QvXy5s+eonKz3Xiudk2Y5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr6C9Ag9t4rYfBc7faM3JAQUJIPVZArCfC2+JHkczL3fXvhtuMEBYqbbCjnDmG02ZKrck96CmoPVPapp3P+7V+K/uPdcLdvJTly5I8E7+Vt2RPrVogT7q9uLIGRrc+gOrBxXEimW4DDWy7O6dMb8EbaAeFRQWDmJ4B5Xn8litmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qSVHm81G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qSVHm81G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nzw9qygSB/J59ta+WzuBL2+bfdyZgxXeGArjKf/sIwk=; b=qSVHm81GAExYZ7IO9LkyrUL9pH
	Qc2GROm96EaAc4xkWH8KZ8WQjneQM50F5DpFhmvjnOGXjIQzn/J2NgN5NL1O88hoOT8S/ZWbWvRdg
	HWMNtak87YyfReVf8J4083EU+NTwfSWDl46LmJHTBYjFTOLcN7XLgzPh5SkDqPwj+sVmIry2HkVCZ
	j6SAGlZU79gt3oTOkI++hl3LwUNiZ8GPkFguiAxRynrjTHEaW2rDaZUpkEvk2TS8/qhmwiAMiWy7W
	XF4ZsboJpnIFZh8qidHK27bAJJYb/w10Pw4tUMnwEbuX78OO05lMTEHTRhg0Bp7p1+JWVt5WclpiB
	+DmsMCrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8RHH-00000007f4a-1UB3;
	Thu, 02 Apr 2026 23:16:43 +0000
Date: Fri, 3 Apr 2026 00:16:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in
 shrink_dcache_tree()
Message-ID: <20260402231643.GJ3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
 <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
 <20260402224439.GI3836593@ZenIV>
 <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7O-p8L7384myYTus6NH5aYdoS=y=+iALL_8DLT3=ZLw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 02, 2026 at 03:49:39PM -0700, Linus Torvalds wrote:

> In fact, the __hlist_del() *without* the init part would work fine for
> me with the comment.
> 
> But it was really the added
> 
>         if (likely(!hlist_unhashed(&dentry->d_alias)))
> 
> that made me go "why is _that_ needed?"
> 
> Afaik, it's a perfectly find hlist entry at that point, and no need to
> add the hlist_unhashed() check. No?

The incremental I've got right now is

diff --git a/fs/dcache.c b/fs/dcache.c
index 09a80f7f3d05..b83c279f34a0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -455,8 +455,15 @@ static void dentry_unlink_inode(struct dentry * dentry)
 
 	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
-	if (likely(!hlist_unhashed(&dentry->d_alias)))
-		__hlist_del(&dentry->d_alias);
+	hlist_del_init(&dentry->d_alias);
+	/*
+	 * dentry becomes negative, so the space occupied by ->d_alias
+	 * belongs to ->waiters now; we could use __hlist_del() instead
+	 * of hlist_del_init(), if not for the stunt pulled by nfs
+	 * dummy root dentries - positive dentry *not* included into
+	 * the alias list of its inode.  Open-coding hlist_del_init()
+	 * and removing zeroing would be too clumsy...
+	 */
 	dentry->waiters = NULL;
 	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);

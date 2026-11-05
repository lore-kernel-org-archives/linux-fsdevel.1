Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896217;
	b=DIIggc9i+/a1XrvG24IhDXdLnF5/ua/OD+S0pwtLVHJZTk9jhiZLCgguibFJl1rMFtkd
	 FhNm1n9St29Y7tOhWa0J9jaVIqjRGBeHGdG9JT4GcGd5uKuu7BWs6gOBzYpQVAFjCyaB/
	 i3hXkz3fh0zYu92ceyBJhLsAyLY1xs+98DSWVT8W4CF+jWtXnqrYFKk725jpQaMJxEsuV
	 v85SbZ3fDEpZHHqvdtXVjESWwDVefrG/Tjnm0ZeJ7xH4s9H0Vo4behkwATprEAsDhJeGl
	 0l6QaOoAo+XyT6U5q4I32TR6HnOFv3Tz5fpNZDeIMuMJcX9zD374CMB8CoJ968VHoTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896217;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=AeASCDec/Pj1QBGd50GZKzwcOgx7Z1HfhASuDmTxC5g=;
	b=j2iziKUpAJ7y5d3uQoqa8LgtNIIsnHpU1oNGjAImYJMx8DGiU3arQvdYA5sK5tpt6lsM
	 ecDXyBg8bwNniIZ9LUPF0HtTA4PGmK4GDzqpFYMdoqPqu5fh780jMlJ5GgILEBbKI+R5s
	 Ef85s8+ipaOR3PUb1XXTouE5jd2++pm7K1Ot3unTkMA3+0ICvQTDySnGQTb3IoW4ehogf
	 La5QpgssSBWpPo8M9aMbG3y4iW01Dftmz5Slt9OvPRxolIIJKMKmj90k1IAHG3BS5GSZn
	 oJgJC9lfmmTIJq6TRgxb4AiNcbSMdNbJcmDS51qL/4OJWK9WakoEhpaIGH+PWo+B9WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vk3jyloF;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A975606A326;
	Thu,  5 Nov 2026 16:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A975606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vk3jyloF
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 163301A0B79;
	Thu,  5 Nov 2026 16:30:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 53A3380011;
	Thu,  5 Nov 2026 16:30:13 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:30:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: How to detect inode leaks?
Message-ID: <20261105113012.5c8d8e36@gandalf.local.home>
In-Reply-To: <20261105-lesbar-puzzeln-duett-fc7bee207796@brauner>
References: <20261030161220.6f773b1c@gandalf.local.home>
	<20261105-lesbar-puzzeln-duett-fc7bee207796@brauner>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 53A3380011
X-Stat-Signature: 3cfm5qwje8bwrt5h4qc4y5annp9aosfg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cffr6CuRT2YvJB53hdkbA60SaXuXLMX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=AeASCDec/Pj1QBGd50GZKzwcOgx7Z1HfhASuDmTxC5g=; b=vk3jyloF9094pLsae1dM5kMxVnFrjIzCeR3fbXqE9uLnDsKhOY/OFP/4h5bK22ZtexNSigyQU7lATMT11A0jkWKzdbJYfyZ9CqFqbMPRLz6ciY0lhLm7zp4HWNKNCA6/NSIALpZ1JaRJynXiv6brH2gMnZdRU3Zj5o/3bAsJrus=
X-HE-Tag: 1793896213-708694
X-HE-Meta: U2FsdGVkX182cmhZRUpX9nvck9Dbq18kXi76kc0upDCb4dYY69UwOTRtiNDMGA2jigyO9RDWYPcoPKKdIJ1CIaJBMFjILOSMmDkMN1P6tDqTyHgjiztaLYQUW6Hn6CBbRwvun9vjhnnu/1nMKOdgR19qcp+zxjZDOm8lyzkqQei7hLpCG0fdHdkjAbY9hZl5X+uVvrLNVVkx5ho44ynjH+rYjTbwSA5dxYGocKld+ovaW2GUlkfw/2Y9itIMqJrhASGkWvPi44lt15b7eLP7dgprjpm7fDhkJKltIg4MrLkFkKH+t8pB1T3gC3RRPxuIfaQ/1wON+dS391WCkzD6H9YoIZUT7hVj

On Thu, 5 Nov 2026 16:58:28 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Fri, Oct 30, 2026 at 04:12:20PM -0400, Steven Rostedt wrote:
> > This got me thinking. If for some reason any use case of alloc_inode() did
> > not free it, kmemleak will not catch it. I'm guessing because the inode is
> > referenced by something somewhere (where it requires the drop_caches or
> > memory pressure to free it).
> > 
> > My question is, is there any mechanism that can catch leaked inodes?  
> 
> Yeah, but it won't fire for your case. generic_shutdown_super() calls
> evict_inodes() and then complains about inodes that are still on
> sb->s_inodes:
> 
> 	if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes), NULL,
> 				  "VFS: Busy inodes after unmount of %s (%s)",
> 				  sb->s_id, sb->s_type->name)) {
> 
> That's all. That whole block sits under if (sb->s_root).
> 
> Your fill_super() fails before that's set. So the superblock gets zapped
> without ever looking at sb->s_inodes.

Thanks for the update. So leaked inodes are caught as long as the
fill_super isn't buggy ;-)

-- Steve

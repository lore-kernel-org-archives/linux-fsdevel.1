Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB371DF73C;
	Tue,  2 Jun 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406453; cv=none; b=h8lhfVKkgdsxuRJ8LO2HTzVp5zc2kuS3WWQINdehURWqDRj2Dvz8b1o80irZbH+wKA9sgg9njvHANI9yArkxxNyDdTrUD3Q6Kgs/ujfGjJshVt2DxMgiR6Hgs5xMNnp6kdSKWVVDwsw9wGvK5TIsMSGo/Glf7ygeOTzySyMAWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406453; c=relaxed/simple;
	bh=rVnUnQX8yaFrENwslTUe2ZtTG7KwuK2PR4aHa1oac2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy2f9Q/Ovc31nm+ZaNvpt8ofrmN5DFSF/FD9/kxLCj8cTylPFcITKL1jLF2ycg1MSrtysLVHIVBYsSmubOWyyQur/3e0jdU4CS50b+c1PATRWgoa8pX43O9sJluKvm9+HwRLUsXcDu6edtr0wbVAVIbdnCO9ckxzRw2/EkFyX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlDZ70D4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlDZ70D4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106F21F00893;
	Tue,  2 Jun 2026 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406452;
	bh=3fBXQTkgYwlxF/WwCZe3LkMFK0cUfjEsfId1KNEul14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IlDZ70D4sSBLxNHaOyPmcUENfjwZ6wFb9PlabDF3GQjw73Qvcfy7CIplqxDijnbRV
	 YSM3yjZ0mE0HRC6qNHh+uiRVjMlZOxLo6EbJOYgp8Q81cqQ73CQT0FT+EpR62XovuI
	 ymgrMgT1IS8qwIuQFgY2gxYJnhqmTG8WaxFtSiwfqbnVnNXq7xaT29tNhnWp0YAPLg
	 b9Bfxeucj7hyvMpVrfm4s3AvqjgoDZLZWaTN/rQFoUW5rEPHrdZhMC3AiAJ2Hn7tnW
	 FqSxk3REbXUswTtidvWA2QTLNjpgVzVVBKwW2RFf2oMkN2cn8VUOj7TgB/4nZvGsxX
	 lbL/bG45Q7doQ==
Date: Tue, 2 Jun 2026 15:20:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20260602-entmachten-stegreif-wohlverdient-23303e323f54@brauner>
References: <cover.1780133499.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1780133499.git.namcao@linutronix.de>

On Sat, May 30, 2026 at 11:37:30AM +0200, Nam Cao wrote:
> Hi,
> 
> While staring at epoll, I noticed ep_events_available() looks wrong. I
> wrote a small program to confirm, and yes it is definitely wrong.
> 
> This series adds a reproducer to kselftest, and fix the bug.

Please resend on top of vfs-7.2.eventpoll... :)

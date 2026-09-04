Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFD83E558C;
	Fri,  4 Sep 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517682; cv=none; b=TNYjZOhMi4LboDHUULvv8smA5hV2zqNvonCs1S5n2qV92UA64ZKQJMqG75P4WGBTFNSgNY4s/KJEM33uGlv8yNapWUL9uDRDkBCrsuaAbQgThv8PhaunXsxB1OzUQN/bqSCKtCJ345pv+H+LmQTwMmFjDwbTW64vBzWNdbKW9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517682; c=relaxed/simple;
	bh=Wxi4QLkMt7yCafK+vWErvjbZ67P91pfTsuTtTlo5z44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZnT3bZMIS+Z5PTe5t5rFmGBLv/LFTI6JMxc3LOgn5PZn2AdqVSXQR2FPYPV6tCkYuTaKs05FxHUFR2YG3sp07JCfN1+ZZYZPYyJtzYRjlW7Oex0wKhdZauuw1T65zQOPt4uSVe2m2KBgijrvE4GHgMyTIQRh0Pmg72brpuFtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqY0Tu3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqY0Tu3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F321F00A3D;
	Fri,  4 Sep 2026 10:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517680;
	bh=Z5uJkJhagrwdl4sZQ1qPHpYHc2S+e7JnS08j6EzBqQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gqY0Tu3wXVzYMSmLWPbyDK59qOz1oMuQGaXKFGMTG0gLFo6jCCJWxoFQ2mUQxp6+Y
	 ELt5BM9CBVfbT/Wbw1BkjurvS+4TzFAiZVJsK7GkTechxStOnGMsTth5OD3UhbpG5/
	 mI82fbGmJOXW2io1gRWN6STjKyg8uy0pmMrJRx3USzcyB2hAH7GJuw/HkNUiGrixOL
	 jFVVIPv8FDDkvRmbh2appi2tvHXtFHlX2Spd78jNJMkYZwNPugMdkysBeTO5P8ppY0
	 iflWPmcxZ+UKy7gYPweNolZ56rDR7O1/n+4f359pTh/R6DTcttPfEb3aiYl0tgBpfB
	 Uh7XnaCK22eYA==
Date: Fri, 4 Sep 2026 12:27:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Disha Goel <disgoel@linux.ibm.com>, shuah@kernel.org, 
	wenyang.linux@foxmail.com, jlayton@kernel.org, jack@suse.cz, djwong@kernel.org, 
	aleksa@amutable.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/filesystems: fix missing and stale TARGETS
 entries
Message-ID: <20260904-textpassagen-zugezogen-fachverband-3e338cb727b0@brauner>
References: <20260703150742.58991-1-disgoel@linux.ibm.com>
 <20260706-geerntet-neonlicht-liege-d005ee1904b3@brauner>
 <cecdc333-f58a-4e8b-a3f5-774fd0e69cf7@linux.ibm.com>
 <20260902191720.464705fabe41818d747ff3c7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902191720.464705fabe41818d747ff3c7@linux-foundation.org>

On Wed, Sep 02, 2026 at 07:17:20PM -0700, Andrew Morton wrote:
> On Mon, 31 Aug 2026 15:16:45 +0530 Disha Goel <disgoel@linux.ibm.com> wrote:
> 
> > Gentle ping — is this patch merged or queued for a future merge window.
> > 
> 
> I can help with that ;)

No, that's already picked up in the vfs tree where it belongs.

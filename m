Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAC3A1A50;
	Thu, 21 May 2026 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363561; cv=none; b=q6ivubzeMIaPGPIwzarYYt/+lImTK4ge/QROxQiVH+XGJxXmxvna9P7cVEMpa5/x2kdLA6Jk7xh4vbIs8XpuxHJZ73XZv63npAYWQaIs4N54xnohxJSNKdQgZ42lH1zFgHvU3RKKvRmXmklUZXnaSIH9C0PNwXY1pxPs7kHgxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363561; c=relaxed/simple;
	bh=xcgO2hdH1TpIvePPbwI7koZr8mx1yqhIOe1eNYpTAzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myoJc9mUfPO5oaIMebY0bWKdBsFA4olva54dtaMAVI3K46TQQXiHrdwfP+/UpD4nDF3eNMP52ojHDJ+hNVK9HbbvDAvVP7wMDCgnCB6WvFBsUJRpkmw6mH02FrdxIDFAdOYtPWklS1hLeZoQ/QY5JsMuwWjuWi9ZmBAYEW/xhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd8dgqHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd8dgqHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0632D1F000E9;
	Thu, 21 May 2026 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363560;
	bh=xcgO2hdH1TpIvePPbwI7koZr8mx1yqhIOe1eNYpTAzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qd8dgqHLgdce9NQ+shJdZROAawUpnTrROLNRl/4wBjSf9AvVQ+oGqTRaLAELdbbhg
	 VHqAvb7nJwxoqQql9D5UedtrETChtGH8l24tnOj6kwGy7QcbEAnVGkBkV8hr8SmTzh
	 0fNG7v6CWHU35RUg6x/Jd1bEaiWSukTUyl4NWvGtyfxxht5RztuHJlznlRwqy0YCDX
	 qhnjEu/m27FEx2Yz8EltWZxcTLARLZc+9cw5Le4M1cn1hOHxrtK8v/g9+2ie0c9d25
	 kM9zZiZ5EXbYO4HqMhisL+tX6TCPLimGX4If2QSzUHZe2rEzlsMiYunFKE+bYq62xl
	 sRvpKos/jXUlA==
Date: Thu, 21 May 2026 13:39:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: tahsina13 <tahsinahmed217@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: fix typos in comments in dcache.h
Message-ID: <20260521-gezwungen-sporen-fa7b71cfd2e8@brauner>
References: <20260418184704.8040-1-tahsinahmed217@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418184704.8040-1-tahsinahmed217@gmail.com>

On Sat, Apr 18, 2026 at 02:47:04PM -0400, tahsina13 wrote:


This is missing an SoB... So we can't take it.

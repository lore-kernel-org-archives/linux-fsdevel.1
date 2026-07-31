Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD874266B2
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502106; cv=none; b=kKzrnb+OCRcyDhAoHEeKsHdrFPq1SwA3kT1jBrUC3CZcFto+h8ceSzmzUpQiHRL11PNBZzQ0oFjuAZbkyUR0g5yHgvSaFNJwx5v6oOORZEvg5BZXVjJ/9BhbVCSsZ2du2j60TlthY88lQSaFuP6QbqUMKGnZpwZQYzsL+7BCPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502106; c=relaxed/simple;
	bh=9o4yyER6g+oFqB9p5XNlQX4is10vCseMWYjeYbEjFOw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DifQkQ1aHsfaXhoJghjBup/wYgr6eFbcXnvWrF+KJemJViSh4vP1SMZJcSh+YnFThcXynvFdtRNz9nr+9YP1YDtSFo5CQs7fT2fRdRKydBtqFFADYDfCv/PQMrYakzyBqQn5EwCQwetYISjNIOATECs1UawMbkdb0TI80nYywIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjETnfYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjETnfYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A071F000E9;
	Fri, 31 Jul 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785502102;
	bh=ZAYk/KKfmsg6THx5BD7OJOp+dymrCUbr2W7bNk8oswg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TjETnfYao196wQO9M8Cke3zrqNzTyqXPIuWJlnlsKMuRRNAXdEyk7Uxx20o0QUYUc
	 zfbvo8WLyCSDZtYRnjSVEXP3RmXuoSZwoHbgT9+ulGVwu4uXgt+aIVWrTIf8rFjqw1
	 Bq3DuxvrAblBhv/uDw67KEfgOqWvkMpkX6vnYhda6UrYoqQfR4CRgtl2sLCCv42MUS
	 MQ86P9lKhW4+v/UK35YfXHN4SZJfVtrtCQL7g4y5KRFcHFrllm7z348k3dnRZMcfS4
	 gWiCyNbRB/NceHBcLF5ZcpIdh5TDVKVJLw8wmG7aOumAPX5xR1pwr/xal4NQ3VxXc9
	 V4UYtg2G7KnQw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fsnotify: Remove Matt Bobrowski as a reviewer
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
In-Reply-To: <20260729140032.4022470-1-jack@suse.cz>
References: <20260729140032.4022470-1-jack@suse.cz>
Date: Fri, 31 Jul 2026 14:48:20 +0200
Message-Id: <20260731-fettgehalt-schuften-wohnen-a8691de64ee7@brauner>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=471; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9o4yyER6g+oFqB9p5XNlQX4is10vCseMWYjeYbEjFOw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlzJxqdsvBNp1DNuNd/cHUS6xvXh3NW35rk9kmkQM2J
 o12thElHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJXcjI0LqByVsv0IDzXSFb
 R1Hz653tnTt9FIXUvvU+152RkfKFn+G/t1RM/j8TtXf7I0rUPhnuvtm0nUvzvkRXl+5+IXGFRj1
 eAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-29 16:00 +0200, Jan Kara wrote:
> Matt was not very active reviewer in last years. Furthermore he
> apparently left Google and his email doesn't work anymore. I didn't find
> any working contact for him so at least for now delete the entry with
> non-existent email.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

One datapoint: He responded to me on a bpf patchset about 2/3-ish months
ago. Not that it matters in the grand scheme of things...


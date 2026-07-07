Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF23EB0EE;
	Tue,  7 Jul 2026 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421495; cv=none; b=GcPxA7uKgDr5bt0xKIp7ytwZ4micwnFAYr79M04WXWi0vj+/azSZQi1WuGzedx6JOJjJBv7Kz4EGVJcK2JGtDAwNmqUHtjx8iN3rkffPdORQF4iyqNj75W4OUj4W2RkXe1kUpckCYBiVbfCkJNmlZRXxMFqSRAOgLA0EhzjW89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421495; c=relaxed/simple;
	bh=UzHvsy25R0l0O1aEqyNn4wy5BFvKhPAW+/Fcx4OrWZU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kyyzCtZZxBYnWz+RataNMl/0zx8wWireDsgr6cPRhFezW9nERcctzJ/IuoDpbmPCn8P88y68VK/4x9rmsBS3F4JUMig7KuY4BPqC9SjEb7JlmbJ3UwbNbCR+MegVCJmeAIzwYPl0IYi2H38jzfz3HVUjA7as3ok67cZGBE3MFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+6UHwj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+6UHwj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7561D1F00A3A;
	Tue,  7 Jul 2026 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421493;
	bh=gcI18mRj4BWBkHflAmuv8EUf09cQd+2K4mChxMOQvRY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=i+6UHwj7RiXGKmyRCAHfNI+jkDDlGb8oeuiwKIGujmqVT6xI6G3epyUCqDk198sBR
	 kUkmYsMsoYIKyubu0LaDFBCUr00x1tPxBKfzH1ySj1MzzeGmF9K34H2J1sj64QQQQA
	 8ba/29gqKwx7BYUctI1qhZ4sN83ds3Y4e4WoJSHYaq0WzfBghW7Hy4O2pDwiq+yktF
	 HYtHDQy3NosuZhg/6ZhZtgVusd8P5QUVC3cCGsf+niusPZIpHLhI17+3TMrpLwHxUt
	 VdvDMAiFn3Z+qV9NKQJekAFCZWTNiEYPAFthAeoz6mGNboBiG27OT8WLa0TEw99oOc
	 LK5iD9vxY4c6g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/14] fs/namei.c: use trailing_slashes()
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-2-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-2-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:22 +0200
Message-Id: <20260707-global-wachhalten-nummer-ccb6f8d736ac@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=563; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UzHvsy25R0l0O1aEqyNn4wy5BFvKhPAW+/Fcx4OrWZU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53NJfFbfx7KKQLrXoJGeOGZxT7FfbXHrD9a7F4t6Nr
 dXcS5/2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk2kNGhqlTT+9Y2CXLdJUh
 ZklmMu+Gxd+es7Zvb2a5rPIv0L95PifD/zwPAe/0jbZLznktvraE34lDeB2nWIQBj+ZxjZzbO39
 sZgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> There are several places in fs/namei.c that can use the
> trailing_slashes() function to improve intent.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 19ce43c9a6e6..a8890bc0ae21 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2781,9 +2781,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
>  	return s;
>  }
>  
> +static inline bool trailing_slashes(const struct qstr last)

Should take a const pointer instead.

-- 
Christian Brauner <brauner@kernel.org>

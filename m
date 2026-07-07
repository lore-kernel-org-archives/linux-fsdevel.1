Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543523DCD90;
	Tue,  7 Jul 2026 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421502; cv=none; b=hjySqeXrODrAibPwgaZX2V0DAZzOOK3r8ngojwDYX4jPhn421Jd0uq5HIcXAa8Z4Fnb9CTM4s7MQDpU69erVSImvW7Kr5mv9lczTRvWAgfitrtffYXyFztdFLDH1oEU4WWnOVGoUQh2ZlcMIbJUxInt+oNmI1Alc251B+LIiA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421502; c=relaxed/simple;
	bh=trFfqBdfvrC9bWB24LIGSukjc8lgIq7n5UhWWEMZhPM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tSU5bDEJPG/EZNIF/bWcwR7sDQ7FhdQMx8I0uC4kRyn/WevEHpeqAuYCc8NCc5qgnLCbDpZ7Z4YoZlZxrBrT9OwRUXylkHYGjN8aW+q6AeJLYUQpuIlgEe2Q9NVP+04eR9YiLqo2d77JZhwKfmKcp81pPO92WtiOlucQFcuGty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHljGd8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHljGd8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051191F000E9;
	Tue,  7 Jul 2026 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421501;
	bh=Gf9gGbAOffW7NmRRpPAjNyzkr/a8nmuNy7Sui5wBUs8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=CHljGd8i18ObNsQlaGRzDH8vxoWCcr2SZjO0wubeuJE1LAtTcDcMJSSpAD+yKi5yn
	 X2bFoV3iAkXZcPmqVkny6/Us+egseVuDo46peDTUXlu/VedVh74iJecmuW0FiS5LV0
	 71chsCYcZTpK/Dij7ef26JbWLRU/f4Tx3c+mBXIlIjR6svgikT/is7biEPQU6Vf4zI
	 ocAvFujRNNebq76cIwjQHPrCTJ+UcTD+XQKwRXIxPWaalENS2O+n+IF/Tj+juygbvR
	 3k/Tcv0GGHV681oIQnVXI9/QvClgsi1VjIwvmsdUWldWpVLEA4rPRsdUYK2ic7fJdx
	 3eyYhxMVDTKZA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 05/14] fs/namei.c: update docstring of atomic_open()
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-6-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-6-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-analphabeten-anzog-gekettet-589a471e58dd@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=346; i=brauner@kernel.org;
 h=from:subject:message-id; bh=trFfqBdfvrC9bWB24LIGSukjc8lgIq7n5UhWWEMZhPM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DIQ4y2beOfAnY3lp2KUhU8zJTM4Mee0W67OzrTmc
 XpW/j2oo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIT2hkZJrPMr+rYGuuZIiPl
 vXZu+tIrmpPV92u7Xba83hL7JF3gMyPD0yP2YcczU165CZzQvyq2Q/xBl0nfj20qFz8UVv9M9Dd
 gBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> The docstring of atomic_open() contains several errors:
>   - It does not return 0 if successful.
>   - path is not updated
> 
> Fix those and be more explicit about when FMODE_OPENED and FMODE_CREATED
> are set.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Unrelated fix...

-- 
Christian Brauner <brauner@kernel.org>

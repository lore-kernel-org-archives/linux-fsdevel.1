Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9E3F6C52;
	Tue,  7 Jul 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421512; cv=none; b=jhWqnNCojoEg02kQ5JuJXMNsReHG6CD0CQXDfNI5TeAqz/unnr60SZZnDfg3GlT6mj6nJeCbhKYf3ATic6cwhYbYUYQDN89VwgN3uGIF7fik2KQqp3SnHwq/aStzgMo6pn4AGhVTijamUX35UildwbYRWsogwChwzzzXyr1FY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421512; c=relaxed/simple;
	bh=yxCEtMO+7gBMgc5n8tSembdFzXF7qgyyNpudlB15YiU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HBxtceZRFoMX3UFnRNNHqPAvjcMy9TP/64vfn8BmAvCxF3bvoZrVx7RauLI52YBSK8koEXzMamJO7/HXbfep+A2SskTqXzXVRoPqUXzsTvAwvgUNcZXbFi8S87maq7ZDXL/hjA1TW9KxywxgusZn4s67ahbyLv4Xq5ETf1NlZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZKTY7fC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZKTY7fC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFFA1F00A3A;
	Tue,  7 Jul 2026 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421510;
	bh=/ul1S7fAvRUWL75/2ZR9r5EDRx4sjHRUOqVI2+YipIc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MZKTY7fCIsAWQiCgP737x8buPbWJgSpsTNbxjfXhEcvhnEhiYABW2/lVQFiMME4/1
	 tDOxC4uHFab7LX5ex0cpyVDEEfhBZ3kjtTc4qc8EP6AAc84P2hkX7tZ+6NUDYc7DKf
	 2usQ/qgRhdc6/63SsvvleqEDcoLdegKOyQfac0gMtemHkFyktH1Ht0YeRPdkgezRqX
	 HnvDXDAsBnwJZcQAjQUcnJgfw/cihZ1ot0GsMDB+hNXKcsYjOzYMExKpRxaNrSbRx9
	 E04o0QEBkPYZP3wI2cS44+RB7l1Pf5OYTN2e+2YO0NI/elY3NLT4Vb1deLxe6MJ3V4
	 DLdrScpZCgdLw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 10/14] vfs: move O_IS_MKDIR check from lookup_open()
 into individual filesystems
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-11-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-11-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-mehrsprachig-blutjung-beikommen-ae8f28c5cf1d@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=413; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yxCEtMO+7gBMgc5n8tSembdFzXF7qgyyNpudlB15YiU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DIQcK/4q7Pi29RpHSe9/S/+S1Tdt8JuneTPOm6xn
 qQZ5vIFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPheMfwTy82SXf+l7nH5p57
 ttVU2lhw/cvpl7rEPTL2z2Et95fbcYXhn6ruOqP/e9ZYpFSstZibYqRruruiXuvzop1Bk8/9ruN
 zYAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Individual filesystems that implement ->atomic_open() need to get the
> chance to implement O_CREAT|O_DIRECTORY or not, rather than decide
> this at the VFS level in lookup_open().
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

I assume they all reject O_EXCL without O_CREAT?
Otherwise I have similar concerns as mentioned in the previous mail.

-- 
Christian Brauner <brauner@kernel.org>

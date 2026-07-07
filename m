Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71D3F6C41;
	Tue,  7 Jul 2026 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421514; cv=none; b=fhxxv0ykzytL6HxWPWDDzxJ0FgqEJpsF+W4TRswmeufp9xNVehNEPuRaz6jk1pgWtbJFQINkligwS95GA5BuMjDlVkrD65EdI90/R+WA3do4ama25/1wZb2etjtbvactNCoW+HHq4PmbfloTR5MC8IBLxDVTKRojJti4wX/+4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421514; c=relaxed/simple;
	bh=tytGwSm1w6vdmmUuaGGTWd9+CHY7d9byoDY3X/EZNJs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V3MUB56Q02siXt/5276036qtRkLPJussmKYXWD0QyPnxAxd+NrQyCWT6NBMFFoaknfVIJoTg8/aSIKEKtyt26nHnFo1oyXmKfnxhfyZ7/PC5XkrWZ74AjbvRkNNUY+KynADWrLeGbirI3RTLEKgnOJJTF8cQNIfsvfw03Cg+0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpuPG1Y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpuPG1Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D6E1F000E9;
	Tue,  7 Jul 2026 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421513;
	bh=OFtRo2k1roFGjTb/ANZBxZ0vG+sP8azz5fxTMxVBIz0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NpuPG1Y5Ey9aFfNwKevfhUbE+Rksof2kmDARcAcK+C32Hmvf6rCJ0TOzrLefQ8yXN
	 29CEM7ofDn2GIeXPrXIFrnkLiYnpsdGT4+zlMwqxO0g6fx5g3OLmKlrkWIKfNBcKzm
	 t5UbWpBknilXvvWhjZJczHRukd3tGPWpzmGZq/sg9Bb3Z4i+rB1uwjjs5wW+cyqsaz
	 JYzdTa74Eyre+7Pfg9vPyb6T+IlsuieyJXETtEejgt21EZjCnny4tZ3A3M7mKbKnUk
	 tL8c4GkVwoybtgU/zvqXjah7BPEefXzn/rM8+JsuyvRihp0Avn6bldUn77y9SUiRDj
	 M1nbJo7+s83ug==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 13/14] selftest: fix headers in fclog.c
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-14-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-14-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-hemmen-rausch-keramik-72b99d4daf4d@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=121; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tytGwSm1w6vdmmUuaGGTWd9+CHY7d9byoDY3X/EZNJs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DKY2Dpt5aoZi+7PnG/4773uRYXXN//MvZmo7DkxW
 u6MaNNri45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ3DrL8N+VX3XPveMzI6Vq
 v6/WuXNzc+fUbjtu3j8GW2q5r3Ses0tl+Kf7abrBMrcFc2RdP8v23svOdXbTu/2MjZG9TuV2r3j
 nFBYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Unrelated fix...

-- 
Christian Brauner <brauner@kernel.org>

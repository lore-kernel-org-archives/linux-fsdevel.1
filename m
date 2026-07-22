Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCB2AD00
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722402; cv=none; b=T9ZjzO54vfpZfqMlNUzJUShdnNPHdv99Ad9hBmk9nJOFqJ8XWn4kz+6GBuHi06qFMflQbkPTgceGFd2ocuxVFX+BZIf/o7nj4yEl7lq3k5a5N0LqPU9s/W2GL0MyaqsZi/+WQMitZ9qHx4vWeVdCXnq+mBypGcCtTs+2oKd6K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722402; c=relaxed/simple;
	bh=vCttxdAeMIsroKhcP8cJtajan0gS6ZcUhOF0G0ErDv8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=E2b3E5pWmCCPQGIBbMgXi+GWllDPTDFG77ocE8Ros5Iwml2MJNv07huDaNH6psi+E1XB36pt0SPoEv5DjuKXqtduM+5Uqo67/C6kPXbOr2OBKtg0W3XOoes6p/FmTpvb4TDEg7MyBDya3qX3/YNmAqj1Kfdvil4YNkXXEFeJHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aouxyucj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aouxyucj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4939E1F00A3A;
	Wed, 22 Jul 2026 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784722401;
	bh=vCttxdAeMIsroKhcP8cJtajan0gS6ZcUhOF0G0ErDv8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aouxyucjS74fzbW1XeRtBu20kceV/YlDeEuU3d6x5pkQKaldA9GyS3MjMtdCPMDVV
	 fpfhETFhkX+GD6zhMPgZyulHnTRKg4E2111/684LGGpxO9MQygy3IMQjZKy1wbng7v
	 IxAw7lOUCSel26k13/EaSAP4LEOGdLf2+FrDY5TZzRte1uzfEOweLqoFXMWUcyDnl4
	 Z+vXpG5EN+VHs6tBE+hkJ/tvIHSHKfNcRuDxBwQHzjb2Feq8kWBvbsgmXXhD/uukUc
	 jFUV/nwbb6SJtPOlJiUlt3AN43KHOqYm0StoFYIrdL3bz32hR06dNVNfX94MLEarQk
	 +Mxxur5uQucUQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 05/24] binfmt_misc: use RCU for the handler lookup
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
In-Reply-To: <alKzv9cAGT0yqSW6@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-5-a162f7cb58d6@kernel.org>
 <alKzv9cAGT0yqSW6@lt-jori.localdomain>
Date: Wed, 22 Jul 2026 14:13:16 +0200
Message-Id: <20260722-appetit-nordufer-echtheit-d08a5965ce78@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=296; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vCttxdAeMIsroKhcP8cJtajan0gS6ZcUhOF0G0ErDv8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlbL7XuPai8qXFxyYd1eWY/sX66OwbIY4HZ/KXXNfff
 aNNU3BBZ0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE7j5j+B9z+FvYWsXL7N9c
 L+kXMVRneb3zFnj3SuWTtPTDK71dW28zMhxvVk2ckhxQeOZK4g+WkLNP/pa5xc5ulrjln7k5/mw
 dFysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> instead of just for clarity. Unmount cannot happen while we are holding
> a struct file into that mount, correct?

Yes.

> PS. Let me know if me reviewing is welcomed or not. Obviously I can't

In general, review is always welcome when it is in good faith and
targeted at the code. :)


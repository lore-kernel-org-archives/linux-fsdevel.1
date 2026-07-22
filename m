Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BF2D8391
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723963; cv=none; b=GQMz3k19awV43Lb+fP4Q0iWu/HJcSR13minVj+vnzVT70mfv/eYoxEYafDu9+PCq0k76qKR+lKelM1B40aa2QwMoz7c725SuiysJIj+gvwX+7eML/FCbFar/cut49YUPZH47oLgkBbQBcyaeBPY7NbnTTtnoysjk/MrCLKqoHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723963; c=relaxed/simple;
	bh=Q4EqQdwIaOSSpaT+7K2vLdAnTXHDA1Zuodr2sfKGqc0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fruQ8zNgzis2DFP5VQz6RI1NGaqUFRnRUCetYWrB13g+e+TizAt2HMLE8QX9s9FHb8qMxq0pQMOENOx2Y4LlCgVoJnOqRtiunLGCXeO/sjgz3wG+IqEaFiW8M/id5G/kIoWWvhpciKrHMhw8vVrmoGyG7zSqv1DWpwHxrPYjh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GREigaUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GREigaUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F4A1F00A3A;
	Wed, 22 Jul 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784723962;
	bh=TsfvvpwCQI9TbfGENCzD6nd/wp87KPNTgFI1Rs4ud4A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GREigaUIFhdM2QPs4yRdUfnsbykB5xq7rqfJQMBYbOzIwQVE0cwi1lY23suhum0ag
	 kQykwZmrBfiHlza3K6OcHsr3O5wZLGW6DKzDY5rDbp3yLKD5OiNixpuOAGzNZcrEkH
	 ylaRI2ZlAHRFNVF1pZaYUaahEF7Ci4OUFJrrtol/wma+dHR0kcAU3N9o+DHpZA9yqX
	 KB9o2bvjeGF3QFpeqBsYfJTXkPELMsvJ/lvl57DC3fxmEH/A4hclij0q7aGiwL9twp
	 RzITWlk6M7ui/WpertQTF+nwMglm/G4baNudNDR8u9hyCsYLLL8fd4Aj8OT2P8pRe0
	 csWBRF5tb6dDA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: VFS: prepare for changes to directory locking
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <178391890817.3371781.14778108771142054222@noble.neil.brown.name>
References: <20260701233128.3356519-1-neilb@ownmail.net>
 <178391890817.3371781.14778108771142054222@noble.neil.brown.name>
Date: Wed, 22 Jul 2026 14:39:18 +0200
Message-Id: <20260722-motto-sachgebiet-hormon-02ece4f57357@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=247; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Q4EqQdwIaOSSpaT+7K2vLdAnTXHDA1Zuodr2sfKGqc0=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGpgufjIyOH8S5Ms3lf9QRHRSHJsk1HfKI9Vr5ORJn1nLJiC/
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmpgufgACgkQkcYbwGV43KITaAD/SNIn
 EsThHg7A4g5Gh7vts9Z0qHeupP9Mbt9n26Y3SUQBAO/6DI4r+rS2STPYAPYuWq6zZ/YQGEB57rT
 6EZzfZacO
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-13 15:01 +1000, NeilBrown wrote:
> 
> Hi,
>  any idea when I might get some feedback on these?

Sorry, vacation time makes this a bit difficult.

So functionally this all looks sounds to me.
Just a few minor comments in a bit.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678E368D7C;
	Tue, 23 Jun 2026 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209946; cv=none; b=lLIDJjwixXGIqMCVmhG4jSZBul19WltnzFOqxQyqAQqFea5VuHP9lIN7zieqBTuUWHtbmu3QHbIoAg07NC4VOt0HaHVEjHF2UzG03AgIn49SL8ngVOuWUCrm/vtQ19bRELv/oz68quFq/DK790zAHv7efw9UkPmV728CKjVAeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209946; c=relaxed/simple;
	bh=XAhS08fXy8omt/j7+jtjnRB9y0myNYFeM5jIA6Pyc6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qS67WHCaSDBWnAf8W+rO+s1ph4VnnKG9hU8Z+VoR//f0eKxj7QP7OLfcDUCbYCGlBlrcCTiIF6kRn3v1/YRmZyRbweQrz/DMlp4PBK4bLhAgYs2l7kDqHAufHCa9g6R4ulqAQ+9Rn5JyMYq86vVmOJmLsOzbWeDCGCmHCgpERqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxFOjj7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxFOjj7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6FE1F000E9;
	Tue, 23 Jun 2026 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209945;
	bh=pFcIWomGINIbA0kPWsLrHkGSvgk5pfa7b9VRzxvyCD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cxFOjj7jiJxd4PbRE1T0+IoQc2ns9/39rPvRiwuQAnS86SEkx1SxnQRGUOfxXp1lh
	 48idQbjA8fjIzmK9zNNWG/IkuqW+EiPlCZ9z6kBAehfGbjmzRR/xVBJqSIOvWrWQvR
	 7jWA6vRi2sooaoKkOIQpmMcSaUoVxYFuftsHi68cYBwwm+LxDNHCXnDwjQRF8XQoxQ
	 Ei6T0t5J3MtHBtNC/9ZOoKcyb+kOHAmS6q8xInr+pfBcd4ENMSGVQZ13it4qYJujzw
	 J+svt/s8zK356H2zO1O007vV5B4/JkTTEXvZdQFrywrwRKdVlxBedJqhv5Bbx79w+I
	 I/xTCbdt7NMcw==
From: Christian Brauner <brauner@kernel.org>
To: Mike Marshall <hubcap@omnibond.com>, 
 Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devel@lists.orangefs.org, Martin Brandenburg <martin@omnibond.com>
In-Reply-To: <20260619-b4-disp-50d2bd59-v1-1-ce332969b4a2@proton.me>
References: <20260619-b4-disp-50d2bd59-v1-1-ce332969b4a2@proton.me>
Subject: Re: [PATCH] orangefs: keep the readdir entry size 64-bit in
 fill_from_part()
Message-Id: <20260623-raunt-lesezeichen-jodhaltig-2a99d6882017@brauner>
Date: Tue, 23 Jun 2026 12:18:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-8bbda
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XAhS08fXy8omt/j7+jtjnRB9y0myNYFeM5jIA6Pyc6k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZxU5XWs18cpZT4Xy+Rc9TNtwqbvYqy9M69XkD6/Swf
 tnzRdeedJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE5CUjw4e+uXI6LIt+PuP2
 +1Ub1XreiGli7Szb2W837zjfwfOIdSbDP93VKtEtz6cYTYhrWK289+lpTg//fWl/aleYFO2b8UF
 djQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 19 Jun 2026 04:38:20 -0500, Bryam Vargas wrote:
> orangefs: keep the readdir entry size 64-bit in fill_from_part()

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] orangefs: keep the readdir entry size 64-bit in fill_from_part()
      https://git.kernel.org/vfs/vfs/c/7adc4b46512c


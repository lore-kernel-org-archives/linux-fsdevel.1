Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968243D25BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092910; cv=none; b=nn5Q4iN/hdhAZ2plaM7kpDc1dkWFvY3qRtrljX4RIUMNkHWJdP4wMLdBeEY5SpcY7BNAHA8W/G1Xzj8OXkqpL5RXT9UH+zT2zI6YdCguBu6HeO5WqwmIG1nzbINigC9BL3Yx4JAWEBrT9Fkr/FSMYHX+r2fyz3tat4VdZv6mBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092910; c=relaxed/simple;
	bh=/VhUwudNUCa9oZWqrFU4GXwx2EkPFiet+FrfpTX/8/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEGZlsNw00q/KC5h6yU8AoG92COBaqiQCzGSC3OzxZZEs4zrhI/rLzdC1TZHKLfkaqzIY1mS9iWySUIvEk4yqZDIryvfufsrClL/WHmQTUKywPaUug5F/r/Hs15jhy3acnDxhQGKxyLABDdetndHFxJd8CKndZuXYnXn89sOG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWSZVTHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWSZVTHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715301F000E9;
	Fri,  3 Jul 2026 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783092909;
	bh=/VhUwudNUCa9oZWqrFU4GXwx2EkPFiet+FrfpTX/8/0=;
	h=From:To:Cc:Subject:Date;
	b=XWSZVTHfULh//623XHhn51BmTnCEen3Q2up6OSALX0krmU7ox7IxQsAYD0Lx2TAVx
	 0HMV52E7Cn7/QvyPOgrOq3E991iRAmFxyV9JZl3iyRyLeXcICiclaDdc5BGEA2znR+
	 /+SJM+lof2K5ttrYTm6HyINlR2ML/ZWGRM+tP+8vuvmS3jMFFzBXmliqnEzffrghey
	 mg1aSy2d5/LDCQ2xVxTtiKHliZpNHK8V0jV2ODftox+N7nLbmMMUpMMMzgmVVg1/F8
	 dqE4+SNWpXNvpIk/IyVSA/ZvQqZ3VcbeA9MnrLa5j0oeusdANlcUwQ043JsN3WcHSy
	 Du4BHm6v2lANQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: Enjoy the Summer!
Date: Fri,  3 Jul 2026 17:34:52 +0200
Message-ID: <20260703-vfs-summer-jam-22b2edbbbc44@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=brauner@kernel.org; h=from:subject:message-id; bh=/VhUwudNUCa9oZWqrFU4GXwx2EkPFiet+FrfpTX/8/0=; b=kA0DAAoWkcYbwGV43KIByyZiAGpH1p+jqaaNEJliO7Jge73saQC3zOh/auF4zPfj0l2B3Uc8x Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmpH1p8ACgkQkcYbwGV43KKSmQD/Th8c 0CcEyfWm/DzdCuDneKQN+BNINvQ9B8cUcGduJGMA/0UPYGfJiU1J18Qo6vjDddP0ncm/71N6biy oBCvxC7sB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey!

Summer is here and many core developers and maintainers will be taking
vacations during July and August. I hope everyone gets some
well-deserved rest and recharge and can step away from the fray a little
bit.

The VFS tree will remain open but expect delays in patch processing.
Please don't spam our few overloaded maintainers and reviewers
unnecessarily.

As with other subsystems we see a lot of AI generated patches and bug
reports (publicly and off-list) where the submitter functions like the
Mouth of Sauron. This is not acceptable and such patches will either be
ignored or heavily deprioritized.

In general, over-the-wall, vibe-coded, complex RFC submissions can never
be expected to get lenghty, in-depth reviews especially if the submitter
shows clear signs of not having actually spent the time to think things
through or doesn't understand what they are working on. This is just
taking up valuable development and review time.

Throwing mountains of code or an endless firehose of tiny patches over
the wall to get your name into the kernel is not a success story.

On a postivie note, the last months review discipline has improved quite
a bit in my opinion. But I want to emphasize once more that regular
contributors especially with lenghty submissions to the subsystem are
expected to take part in review.

Review doesn't have to only mean "look for memory leaks". We know that
LLMs are suprisingly good at finding various issues. They have no taste
however. So review should focus on maintainability and design with the
longevity of the subsystem in mind - both internal and external apis.

Keep up the good work and enjoy the summer!
Christian

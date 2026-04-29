Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1662765D7;
	Wed, 29 Apr 2026 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472388; cv=none; b=hYPaK+9iM6A2WGD3/pL+rX/p3/B584JBl2IopUc1RUi0+NIWYeAGIcu1AaSr1u/0MG5Rw7Kg8tQYgXGhsoiRzwcrSihOGJSJ9xLDdPTLoPAiFSfIsPWuiihJGO5Tsv6+hX3VS6/SVmh9aiHGJJRCCyxc1Qec1ncFJzKdM27m4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472388; c=relaxed/simple;
	bh=CKN7gO7NDqz/SrdpZzdt1UN7IkkPevNSTYUytqzm3K4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSJ+HuPab6jVU6nnqjXRZJ6EptP6qT8v3f5nm75OvDTC67gNiuj1y9hTOtGMkc2ks9nP16zvdsnQzfphZL9Saut/KIO3m9xL3CoMnCuA3f9tEyD9J2tlkknfjQyVt5di5UAp6GYkFYiq0lgvxtxKdF587bztngMEdeZTuIxivBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSbyJcup; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSbyJcup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CADC19425;
	Wed, 29 Apr 2026 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472387;
	bh=CKN7gO7NDqz/SrdpZzdt1UN7IkkPevNSTYUytqzm3K4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GSbyJcupij/eYhySWl9PF8SaCZlFs6LR6XcrF8fGmARxAZeka+TdO4pDR9mXbPAx3
	 axeC4tF1FuV54G7z/8cAGeCiKidfFKq8+kx5+AAW0kEplun7o0NSSu8qTeBtuyeblL
	 aTfte9SRiNzVQsLwLEL3+sKLjvO7l/TqQ8CHzSMp/MBmDogBNr83XeCVYURqtyCfYr
	 JJR/7ppVlMXHqtaghQ36ocDB4jzNJ2mr4ccUn7nNfnofAqNmBktdXQ0QGNZmAlUust
	 iaTkH4qRKMjYqNjhXsodjLYdLWWgSosKG5iwvYKrIAzIGPt/78Fc66z5R5Ag3zOoU5
	 cwuwVFAwU1mAw==
Date: Wed, 29 Apr 2026 07:19:47 -0700
Subject: [PATCHSET v8 5/6] fuse: add sample iomap fuse servers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
In-Reply-To: <20260429141253.GQ7739@frogsfrogsfrogs>
References: <20260429141253.GQ7739@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series adds some simple examples of iomap-based fuse servers so
that we can demonstrate and test the libfuse functionality.  There's a
simple iomap server that simulates an ext4 file, a second one that shows
off inline data IO, a third one that implements out of place writes, and
a fourth one that shows off fuse servers running as a systemd service.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * example/iomap_ll: create a simple iomap server
 * example/iomap_ll: track block state
 * example/iomap_ll: implement atomic writes
 * example/iomap_inline_ll: create a simple server to test inlinedata
 * example/iomap_ow_ll: create a simple iomap out of place write server
 * example/iomap_ow_ll: implement atomic writes
 * example/iomap_service_ll: create a sample systemd service fuse server
---
 example/single_file.h              |   22 +
 example/iomap_inline_ll.c          |  367 ++++++++++++++++
 example/iomap_ll.c                 |  714 +++++++++++++++++++++++++++++++
 example/iomap_ow_ll.c              |  820 ++++++++++++++++++++++++++++++++++++
 example/iomap_service_ll.c         |  377 +++++++++++++++++
 example/iomap_service_ll.socket.in |   15 +
 example/iomap_service_ll@.service  |  102 ++++
 example/meson.build                |    6 
 example/service_hl.c               |    4 
 example/service_ll.c               |    4 
 example/single_file.c              |  212 +++++++++
 11 files changed, 2619 insertions(+), 24 deletions(-)
 create mode 100644 example/iomap_inline_ll.c
 create mode 100644 example/iomap_ll.c
 create mode 100644 example/iomap_ow_ll.c
 create mode 100644 example/iomap_service_ll.c
 create mode 100644 example/iomap_service_ll.socket.in
 create mode 100644 example/iomap_service_ll@.service


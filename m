Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D01306B3B;
	Sun, 17 May 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023667; cv=none; b=Vhh+EeFX/kdbMcG+jpmpZKEhkWRmjMACN2/ranjiEcWtQv2oLyXmHBusTgIAgLjhjHg2P2oeKR70xM9CMwm3rDtO07u1/5G2v9oP+XYlzXnTjRJSCFVFlXMJTdTTfumB73hgfbC62tJd9Qk826zu6ShhKoBRR0mOKAnnC5Kgnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023667; c=relaxed/simple;
	bh=22tWSrurpf3NaBMcqDBzkWIJS6vQW9lUZIKzjyGO9v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NOw2O3ZIeBle7B8J35zrFHzw4V3tbY5nhZzzbvyCS8TbRP/91hbKFgeuaLDbGCXdumLajI+2lP7H4yYg31RK/dEBWGpzvcR13D4LHJlMyebXhPg5mtMJU1a5xpPAmEIWVzpajFhbJNYUCPkMCWAv2pzzQHhKKRS/VDaHvAfKZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=bBXUxill; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="bBXUxill"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	References:In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=22tWSrurpf3NaBMcqDBzkWIJS6vQW9lUZIKzjyGO9v8=; b=bBXUxillX12VYV0nMYZa+wOYrS
	jdUJYRnshiJZcaDvGy1qGtC1EZUxbfTu/xQhiOKdHnpxeiZ0kmPt/7ofURTGpvoZl0Qa9Ie/V7aiX
	wubDANw1qPVyeZDoma2gK58mR+q4Sx7ZsJM3ePN0xXqk3H6PPncqeNciczQWsXfOPnBPdPEKaMqUM
	0pJeFKtYCLM1hKBQmt/+IwG+B8jYk8Wnus1pReqGnX7lkYclCjkhwF3+zbijfU5s3gV69GQkxzP9Z
	kesdJ4PtvbiL8BKE7EFIwUwunXfnYtspX/3Y1yq8vXqTtRLqvg7CWubG6fOv4cEdAbcA5KQo4Vpeh
	3gCoAURA==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wObJt-00H69Y-2g;
	Sun, 17 May 2026 13:14:14 +0000
Date: Sun, 17 May 2026 15:14:08 +0200
From: Berkant Koc <me@berkoc.com>
To: Greg KH <gregkh@linuxfoundation.org>, Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH 0/2] fuse: io-uring: fix two UAFs in dev_uring.c teardown
In-Reply-To: <20260517-fuse-uaf-cover@berkoc.com>
References: <20260517095846.fuse-iouring-uaf.dc5f5dbb71dc@berkoc.com> <2026051703-equinox-multitude-91e2@gregkh> <20260517-fuse-uaf-cover@berkoc.com>
Message-ID: <20260517-fuse-uaf-routing-fix@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com

Quick correction on the Cc list of this series:

linux-fuse@vger.kernel.org does not exist as a vger list and the
three patch mails bounced from it (550 5.1.1 User unknown).
Per MAINTAINERS, the FUSE list is linux-fsdevel@vger.kernel.org;
adding it now so the series shows up in the lore.kernel.org archive
for the FUSE-fsdevel readership. The original patches and KASAN
context are in this thread via In-Reply-To.

No content change to the patches; this is purely a list-routing fix.

Apologies for the noise.

Berkant

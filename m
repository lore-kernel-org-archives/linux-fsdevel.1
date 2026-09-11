Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30641217648;
	Fri, 11 Sep 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137899; cv=none; b=K27nbnkQSplsC8sgYnUocrjveLwh0T2/6NDzJH/VXhR4PElk7sLbJLsrY4l4BeZ2Onk7DvKIgm7D/XquP+G8juNXRMZvN3GB78Lmgf3jCZbQNbG6X0TC8zIxZrCxZ5vwsvLuT9O6b48DMvOTmwvXNZq3dZthQyW+2O7IH1WuRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137899; c=relaxed/simple;
	bh=SpbQslHzWNuDIxMAR5ohBulzMYEWosBkiu2wSYeLX1U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k7+JbhBGNcKWR/hrNEFxlnVQOYyaEfxVbgDdOTSo0KFWRf81NCwI5gZRXkDM4bjZ4hqOVzpve90wqNZiVpl3IP4gpwmVac+SxdQLR1zHqCyeJGhiYO6yjRKOAcT+KqBOsARkUVYT1uyCrDTitiFMPJsVStZbpPOpkWJjzH8MQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Kbac9uaO; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=9WY02/gZ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Kbac9uaO";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="9WY02/gZ"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789137887; bh=oVrgHutxRfr3AXUOhHkLt3w
	7v60fgS/qszY7Uraa4rA=; b=Kbac9uaO/NV5+53ymsh4yp7RL8Emudmuvsk9hxs8ZxhgVLbaCV
	3Uy6gWWqV9XhAyRo/Icog5qPJM3e/gge+pHN7YOzv5O7qKPdoJpXoXY5wxriwkMecighgKF0x9V
	E10FAua5v2SfYdP9g6EhabgYzMeH7/iQzTlzuctBUNiBKk9vvmMjtvQrf9zNnftaQGiUfSvNRYR
	EvTIvxvT8qiDGBpAAZ1xywS6B8SQrObe4qRmdaj5e6HHL/vmJGmfOTUxHU/0plcvSrCRzCcMlKw
	C5DisciHhD3w+STARszrjVi/fshKDKqrzB+FtHJJ3gSYzMrX/pmXeF4eBy+OEidplAw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789137887; bh=oVrgHutxRfr3AXUOhHkLt3w
	7v60fgS/qszY7Uraa4rA=; b=9WY02/gZghJQYyXPU8dXlXJpaBODHWumoi21C0md0yAQilVl1V
	7KYTQapmwNIbAYz03V1PBjaUB0jLsGWUXMCQ==;
Date: Fri, 11 Sep 2026 15:44:46 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Christian Brauner <brauner@kernel.org>, Bill Wendling <morbo@google.com>
CC: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 kernel test robot <lkp@intel.com>, codemender-patching+linux@google.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Minor bugfixes for kunit userns tests
In-Reply-To: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner>
Message-ID: <E834166A-58F2-4BB8-9791-3C42BFCDA91F@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 September 2026 13:58:38 BST, Christian Brauner <brauner@kernel.org>
wrote:
>Hey,
>
>two fixes for the kunit userns tests.
>
>Christian Brauner (2):
>  userns: rename insert_extent() and sort_idmaps()
>  userns: declare the KUnit-visible helpers whenever KUnit is enabled
>
> include/linux/user_namespace.h   |  9 +++++----
> kernel/tests/user_ns_map_kunit.c |  6 +++---
> kernel/user_namespace.c          | 19 ++++++++++---------
> 3 files changed, 18 insertions(+), 16 deletions(-)
>
>
Whole series.

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Thanks for the patch.
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

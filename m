Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A56282F38
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259955; cv=none; b=JyDieNNpLJDM+dV0VFSCM3RcMl6GGfD/vPqt5EAMtEMhA4Rz5yz6M1LdNmWkwUR8Pjr4sZTHapsm0GtB3gkCx8jiVlW96FWtvEMfjLmVrGyBdxAj2fqJxNtEcpQrk16yAE+wYwgvwsv3zFWo5Mes6L91iUOySXwflIXTxLuWI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259955; c=relaxed/simple;
	bh=hz7BiONYy1hZtGbJVJK6pmoFlqFzY56NftWpnMXDY5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZEAnmcaFlH8TlyxfeLuIJK/6ZK9yuPWanKF86zQwqHnJ1INsIs0Nx+RkFX1Ej4y5HaD+rxCUzepoifJS+jJJQxK7ivxcrk6eiy1mSEb1pnrrYBODnRE+0+q3+j3as7gHjH6Obk2kvRKR0xCgPvXKc8Cm5ZG24f+seSbhxGUwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=aTPis0dP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/BCgK0s; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="aTPis0dP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/BCgK0s"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D611614000AF;
	Fri,  8 May 2026 13:05:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 13:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778259953;
	 x=1778346353; bh=5ui82XgWY/qFesvZToFr6ZjqEJjBp3LS1Z9hBL67ccg=; b=
	aTPis0dPNLS9vMJ0bNccCkf0dHiSZQAY8Pc3aN0wuFqMnKwgtQCSx07Q41+AL/zD
	8zXXqcJyx/R50mWyLkf4bY9a36kJfiMdO/3tymHYorsCHy48tumdCEfNetzorgK9
	QyzLq+o5jlErhO9aaZjeQWMiMdRXAb6nUkJHHbLtxxGcbd2zc5eImpZoQxpBmFyS
	9YyP+oVC7pKnn6E5gXI2OmUoQR25+dq83J/hgqrwo9imc8iZuQU6jv0Ofnv6iJ1n
	QdIFum9tuxcd55ieGjO8vNZDge2ezMutsAeBrKhh35i7ppcdL34d6MNiUYlwyKD0
	jH0FKwnWHiNOHmHQP7KZ+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778259953; x=
	1778346353; bh=5ui82XgWY/qFesvZToFr6ZjqEJjBp3LS1Z9hBL67ccg=; b=g
	/BCgK0sjma4wy3TS4UW5Bh1TKVY9ln8yaQzEBBEtp1kraqV563avciZYQprq3fZh
	4bZhYBioDEpF2wbN3c+/FscwaisA7eyLMK/wqf6J5fEXAK6buP1OE5yjXYTOfVfL
	vj5xiq+19WUvYi74uskDREK4srtvEEHAg1iO+ysQ0cM4UewN6JrpFfuC2+PpScOI
	jQ4PCnI29iX+FlAyJQ2BEWaWmk1MngdIGna2NpJdFdHC0N6J066BnM0/q1/cS9T7
	91xtTnk1E1IMFfNThmwyR4X4ORAHctMVXrCCPMQ87jnrd+57oIOaw4/znQ3tcKqi
	RvzDkAu9rHvdyInpQNuMw==
X-ME-Sender: <xms:8Rf-aaWD8EidYVtEQBbhPG9xdgY6NtPitaQIz7j74C_nFAWu3lTZaw>
    <xme:8Rf-af66t3rNxkj0dRb3sPkEQB2VQ9Cn3587pbxLBz3N2A_XpnMIVCYNoswpjWnG9
    gFJJv7sd_8XwI4Z8D23EhTJ8W9oEuLh9OExyW5x5zNu_UmiS6I>
X-ME-Received: <xmr:8Rf-aVqh2F6SUC7dedTXRVoAtNNR8p02igK5oy0Nxn9SlOpw7VUmYy45BYl1nXZ2vkAznulG99iYLqC1covpmxIgooj0iLnjD8h4UXZJSo-BaCb6ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehfuhhsvgdquggvvhgvlh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvggrlhesghhomhhprgdr
    uggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:8Rf-aSmuW13k0TEDnNb0h2YpYH8E3TKqKquGLqASosjeZvj5OhXZpw>
    <xmx:8Rf-aRN0VkizrBaNQj7YLgaGs1HByVAUGIgM9duTDfP3wlkf_-QSow>
    <xmx:8Rf-aWOCavO9Ij7cswwNgj24-X_XafanGmZcYjwVw0p7qCLQmEUfYQ>
    <xmx:8Rf-aShSBk7dhbvAxSQptX-6TKzsm-TQbfonwF0Mr6He-c4sXXTTow>
    <xmx:8Rf-aYlzNVcciUrue5b5jNY0_CY4xz06von4e5jizTiVkkpmnmbbZTFO>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 13:05:52 -0400 (EDT)
Message-ID: <11a04b4e-db8c-423e-a351-e7fd2a8bcc7a@bsbernd.com>
Date: Fri, 8 May 2026 19:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 2/2] libfuse: new mount service container fixes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Darrick

On 5/8/26 00:13, Darrick J. Wong wrote:
> Hi all,
> 
> This is a collection of bug fixes and cppcheck cleanups for the new fuse
> service container code.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.
> 
> --D
> ---
> Commits in this patchset:
>  * mount_service: use the mount_flags table instead of declaring our own
> ---
>  util/mount_service.c |   51 +++++++++++++-------------------------------------
>  1 file changed, 13 insertions(+), 38 deletions(-)
> 
> 

coud you please add this or or something similar to your series, to
silence gcc static checker warnings?

commit 670fb8f4a248cfd50af43510033b8b3167d75df6 (HEAD ->
fuse-service-container)
Author: Bernd Schubert <bernd@bsbernd.com>
Date:   Fri May 8 19:00:02 2026 +0200

    Fix deref-before-check in mount.fuse.c

diff --git a/util/mount.fuse.c b/util/mount.fuse.c
index 802d7f99fe78..00b133e62344 100644
--- a/util/mount.fuse.c
+++ b/util/mount.fuse.c
@@ -384,7 +384,7 @@ int main(int argc, char *argv[])
        }

        source = argv[1];
-       if (!source[0])
+       if (source && !source[0])
                source = NULL;

        mountpoint = argv[2];



All your "Fixes:" commit messages run into

bschubert2@imesrv6 libfuse.git>.github/workflows/run-checkpatch.sh &&
stg push
No typos will be found - file
'/home/bschubert2/src/libfuse/libfuse.git/spelling.txt': No such file or
directory
No structs that should be const will be found - file
'/home/bschubert2/src/libfuse/libfuse.git/const_structs.checkpatch': No
such file or directory
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars
of sha1> ("<title line>")' - ie: 'Fixes: 3e1101057aea ("fuse mount:
Support synchronous FUSE_INIT (privileged daemon)")'
#10:
Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT
(privileged daemon)")

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

Commit a9e52715f595 ("libfuse: don't use SYNC_INIT unless asked for")
has style problems, please review.

NOTE: Ignored message types: AVOID_EXTERNS COMMIT_MESSAGE COMPLEX_MACRO
EMAIL_SUBJECT ENOSYS ENOSYS_SYSCALL FILE_PATH_CHANGES
FROM_SIGN_OFF_MISMATCH GIT_COMMIT_ID MAINTAINERS
PREFER_ATTRIBUTE_ALWAYS_UNUSED PREFER_DEFINED_ATTRIBUTE_MACRO
QUOTED_COMMIT_ID SPDX_LICENSE_TAG STRCPY STRNCPY

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Is does linux checkpatch use two chars more for the hash in the mean
time than what libfuse/checkpatch.pl has?


Thanks,
Bernd



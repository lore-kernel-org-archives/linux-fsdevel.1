Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192246;
	b=Jp3HDj/efyiriSj3OXNurdKV6FLC9SZ/IBSc2/7WK5NyPYYv5kN+Din8AeeyuTSpnoUH
	 GfOx01bqFsr02TVhgwTpqcsHbL2vU5w9fjou18QSwYrQYFpogIfaw5F+AwIIzaCvfaZwT
	 O5aogJvXiUSmhODH+K7UYtI59dWYgrXfWyjRJAT5ypSfmyWauWEGc5UTDSn+XcZpSZV8U
	 2kqd+PrvQ37y7Z/EixgaWB48YQRfot5Hvw0c3UC/FvKLDHAV+aZ3QmRTIqbfRWnIcS5Kn
	 WflqJikgC2Z23k/MNNYL9TZX8RD000likD1VapFm2VG2fRqvpCMc5J2G8qU1QKqZ/RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192246;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ve3nZc6CfK+2Pt/EccX7NgGEXSozela6oGxYTNkBW4Y=;
	b=2hpImrlYCWpIiUNpFV7zBg6GWYlwu03SzY9icxIXon+6T4knIgJu6NCal0GqQKkkdbqx
	 P296JTRwnd8G+UB2npXUevq1cL1aDrjZ02jRsbnGhorhktSQtjf+E7GS+h4ay3NirQPiF
	 rbBAmUKawqZ0AhMJZeh/pZwFr4JFyrYz4gDy+ZqV0bhi/q7splYHSS4WR7Bj+puNoU+BO
	 4+Emw66QTr5L0WR3nX7ZppVoJdx0U2iRNuxPxOr2wEMqCImBAKTRZoD+PelPkGeQwUrln
	 LcUR8C2li1Fo26gnCjwK3N8xg/BTSzLRF+aW+gke4RAxkra2Hwd+w4vQfyZi9XAOKIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P60bn+OJ;
	arc=none smtp.remote-ip=95.215.58.67
Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F760A260B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 629F760A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P60bn+OJ
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xEDXCHS/YWCWxkLlT2J/pwSodE2KNpqOe5MEs15s6Do=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795192241; v=1; x=1795797041;
 b=P60bn+OJx+z1SO/r9rJa5vhUrpgrL9hRoJp9EgItolRLoRdvIU9NCqE/g7CZ5eeRNVmFLJRV
 bQTdQbdrm4GsEBk4ItVnWkTjQh/GGwDYglY58TTpBD8qnhrFPcrmnrK80I5PjZlGWHXFKH/mY8w
 ykGWAtOMIWig1jLJ+tKrAUxU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea5d9678c358f401;
	Fri, 20 Nov 2026 16:30:34 +0000
X-Mizu-Trace-ID: ea5d9678c358f401
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 16:30:31 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: brauner@kernel.org
CC: arpe1618@gmail.com, jack@suse.cz, jannh@google.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, me@black-desk.cn,
 oleg@redhat.com, viro@zeniv.linux.org.uk
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/3=5D_pidfd=3A_use_one_helpe?=
 =?US-ASCII?Q?r_for_pid_namespace_visibility_checks?=
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
Message-ID: <B987F9D7-912E-4714-B54C-B17F6F4A639D@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

>Christian Brauner (3):
>      pid: move pid_in_current_pidns() into kernel/pid.c
>      pidfd: convert remaining visibility checks to pid_in_current_pidns()
>      pidfd: restrict pidfd_get_task() to the caller's pid namespace
>
> fs/pidfs.c          | 12 +-----------
> include/linux/pid.h |  1 +
> kernel/pid.c        | 31 +++++++++++++++++++++++++++++--
> kernel/signal.c     | 23 +----------------------
> 4 files changed, 32 insertions(+), 35 deletions(-)

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


--- Thanks!

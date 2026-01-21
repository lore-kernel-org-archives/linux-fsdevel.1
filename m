Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C434F24D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024451; cv=none; b=kzKtq9pLFOoNSFIARVF9S5NlWIWacUCctFOk0p5h596U/a4vagLnjfkw9FcvxKb2RZeFjCUB0CKMah6zqieavoaE9K005Jg+PhsnquNALlOpXaUh/RgA1bCo/MFwLnvlimceykOOKgqOqJFdTBH6UxK26ljusleMhlRnhWccBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024451; c=relaxed/simple;
	bh=68r8bE6qhwjbZqaNnErslOyPOA3WUR4dKp6zwT9IzoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Def9RzWJ7g4VY9KK391zdm5j+6lefOWa0LOlL1xpZVUo35DwnMNB5webD8s9DEHkbWdi2Fzw64mR2cclGs7su9J8WZ90t/FutXrUAna2EvrKUjgQZTwirTbbZuqeiP0VgwQBqLfxcg2I97EFhvrJznRPFoqDD3umYc3ByfnCWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=0Ihyc9wu reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=i6+eDi5l; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="0Ihyc9wu";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="i6+eDi5l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769025349; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=x8yZEnRd7C3j49tb9f9GokLxR8hXGi7pt3NNBUhXvEo=; b=0Ihyc9wuY73Gdk4rIISHNRbzx5
	nx/IVqQMQV2xOj8dzInpqtbuHV2beiinYWpuadm+XvglyfVk4k/HZWB2ibJJZPxHSScpu8n91wBwh
	FydTqNqze7NFaxHp+5xQQ32AZzqYiL/90Dce5w+BFSyTeLxFDzSjB3hCRH8IBFZAs67HCZBuaQiMB
	DTZ3YchTfXyBoslNXJweps7C77LkKhWN6heypp0de6s/RLOjVxWtZ45O+68yz/MN6j8WUtE8GHCZS
	Lk1mFoAbfpQPbYpUh6u64NMJQZuWWlwD7fIpoYbhdxbQShck+eLw9nGBatup/1Yy2HEun9IjpRUrH
	4avv8+2w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769024449; h=from : subject
 : to : message-id : date;
 bh=x8yZEnRd7C3j49tb9f9GokLxR8hXGi7pt3NNBUhXvEo=;
 b=i6+eDi5l+r28+9l3j38ZuRrNVl6MCmUGvgJqqqPm9D0zm/zDD/J3ule1AWYBuWkhMwrud
 /o0iW48fUQPuhOXighJ4QabSh4V3lI4cb9+Ypj/3FuuRbEMCIK5VRAahfCPQV6dY5+jJWsF
 Hk565tMR+MTGvht7w7I7cz/sotDrMIljnprMADnK/exGKCkHFOMCDx5OziHmxeNPZzAsGq8
 3ZdXLmvu2Ps+hOjgMGawM3cVwnpculqek3iy2Yn5bE3JhZNpBWitv3xQb8m8nHWb5lXBs0n
 rzWf+jeaRwFv3PaTG8i4PUVsLifkPgNH9mzL0NFu04S8cnorWcRJ+76KtHQg==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3Y-TRk6mP-9F; Wed, 21 Jan 2026 19:39:56 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3X-FnQW0hPpTp5-n3YU; Wed, 21 Jan 2026 19:39:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] wait/9p: Account 9P RPC waiting time as I/O wait
Date: Wed, 21 Jan 2026 20:21:57 +0100
Message-ID: <cover.1769009696.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: btT4spd16VO0.KghQ5y7_aIri.TE0BdgckhKg
Feedback-ID: 510616m:510616apGKSTK:510616scHTfb7n3f
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

This patch serie helps to attribute the time spent waiting for server
responses during 9P RPC calls to I/O wait time in system metrics. As a
result, I/O-intensive operations on a 9pfs mount will now be reflected
in the "wa" column instead of the "id" one of tools like top.

Thanks,

Remi Pommarel (2):
  wait: Introduce io_wait_event_killable()
  9p: Track 9P RPC waiting time as IO

 include/linux/wait.h | 15 +++++++++++++++
 net/9p/client.c      |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.50.1


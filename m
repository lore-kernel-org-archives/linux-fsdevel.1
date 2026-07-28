Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5303C9EF0;
	Tue, 28 Jul 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224510; cv=none; b=BzXwA/yt7vimGxB1Ujh3fROAd3M1ujtBkfnZX8mlrHvQdnlEsBvaueQ/CVQSutzEbKu4gVbhkdma4a0qBbYui7OUjawsAJLBMBFzVruklJSGM1jUq2Ztz4Yn0aekMHfN9spFOje86r0B8lrpTbGJLpJOdFXwPxdvx99l5YR7ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224510; c=relaxed/simple;
	bh=E6jN+SFSluDuF5OV8oRq0i0D7Ufy7lYPtcUSjBN0DhU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LNSak8vWuOfK50Yq0H6AQFocDKhsNlB5FMAJn+Re9hhi6GaDCYjPXY+k3T4TiTzAnr7mMgEVz5Yv4V/DFPgeN54Ue9icqy3005Rq1M+Y+bOQ5YMsLrAXdHE21dhhV1UnOQzGtkHqUNX055H8rMWkev952JAdzhTeNO8q9cFFyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3af9A5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3af9A5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D441F000E9;
	Tue, 28 Jul 2026 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785224508;
	bh=E6jN+SFSluDuF5OV8oRq0i0D7Ufy7lYPtcUSjBN0DhU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=j3af9A5T3fy9GYjrJ8XaBLnAoJNfssWIME/8QJyFoqgF/mETMEVz2rKV6A3cFM2LK
	 fHo5h/mG7GK70ukhf0yQ0kbBftNwZIqOd3jm6/VaJ6pseXlP8gogPjgAt9QrIAyc7q
	 vvrNe7WWU64yMGLPgCxnuwVulBE4r1IHOX+LEjnvVofC2xxnutbwR4aBTSiLYOnOtD
	 6iCb+FRhDHAL0UsSBclyVkjIUh1y2e7d3uZX8arxUtpVE7SGLVHRL61fbiy5Bp+CHd
	 jplRR6Em3CIe33IAkSYWmY6WcRrdFxO5oIZqOx0lL1k894VPBHYa3uJAMTfrQfr8Fo
	 08TVjxts5GVqQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v2 0/1] pipe: only enable the extra
 wake_up(rd_wait) for edge-triggered consumers
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, 
 Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 io-uring@vger.kernel.org
In-Reply-To: <amdO3ue2SkPUsC2J@redhat.com>
References: <amdNxsTODR4MCl3R@redhat.com> <amdN6_UX9o1i-ceI@redhat.com>
 <amdO3ue2SkPUsC2J@redhat.com>
Date: Tue, 28 Jul 2026 09:41:44 +0200
Message-Id: <20260728-konsens-erdrutsch-ruhelosigkeit-6915f003a1ec@brauner>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=222; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E6jN+SFSluDuF5OV8oRq0i0D7Ufy7lYPtcUSjBN0DhU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlxFpdlzsTXpRsuEh6cv6igglMUSuUhVfmV4Y8rOfpf
 7r9dNCejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYTGf4XyLIYrzi0+rah482
 WjAffudX9s/1uKS11s7cU4dO/pmuVsbI8OyHk+D5sPKJ+34/Z/rAEKbXuVD1rWfJUuv3jloRF9x
 WsAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-27 14:28 +0200, Oleg Nesterov wrote:
> Damn, sorry, the subject is wrong... ignore, will resend

Fwiw, in case of minor issues such as this feel free to just indicate
that you would like me to fix them up.


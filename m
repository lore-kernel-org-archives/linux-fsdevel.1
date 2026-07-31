Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896348988E;
	Fri, 31 Jul 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502683; cv=none; b=BVspCit1R1jkAb1VjPzzK9efbGdVA0AuGi2BkrXzzIfp3UKfPLAobQoWat3GfXkiiso838TTUHuQvcel4BlaoahrKtQxH60+OoEinoMyXjo/Kpq8gqWyYvywpSjTfvttKVNQvLzdoLf1Lj3WWHQtBlTHoxKfTZ+y9AB8WyQF5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502683; c=relaxed/simple;
	bh=z2dp672+D9J6BSDfWsf1Jb/hgmWKqne5bNDgqenso8I=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V9xzyHriqT1tSPls+qX8k98eY8n+aT5fR/4VK0MwJyppA3/+489wki2/caiIKYpPUc5N43iXjvcq4z7/Iu0Klbl67BXJh83lIj+JyrIlQdiBZARQKcL1S7yCUKLaeIaVJ5HwlY43BK5230MNcnlabWiI4C5izQL/eUfcjD+u+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaJOjuWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaJOjuWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EFE1F000E9;
	Fri, 31 Jul 2026 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785502682;
	bh=11zoYCBSDa2gt109iQxefIqcqfzZeDeW548sYDMttGo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KaJOjuWKsVlmPQY3IiXad//deFzoNKm783P51eGfRP2aFYUlp5/vS0QZtnRl1ankM
	 qGhfFRdk9pZkLLfHBxSU5FTDTMVcVBll9wQStok2wiN0/rUJbej2qiVRB1X13wpSwP
	 ZIuui8a2Y0yIgmL9Xcx9nSicBpMqEVotNf0L8CLEc9XIMq/TLqm6cXgnf/vLwN7+a7
	 cpsMsRlYCFqp4poozaiIFIZws/3L/ncR9RLNyDKDRCo3C31yrkcSCW97tWgqQ2n0JG
	 3uMdVw2Fm/eojOT7o6z+b0XUYLNOLg1AOig/GYMaw0epoa662XqsGeu5u6rYjTGtpL
	 NOzmssC19rNng==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC 2/9] aio: Use accessor for hrtimer_sleeper ->task
 field
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260731004019.3530210-2-paulmck@kernel.org>
References: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
 <20260731004019.3530210-2-paulmck@kernel.org>
Date: Fri, 31 Jul 2026 14:57:57 +0200
Message-Id: <20260731-ritzen-ratgeber-fastnacht-519674d2de1d@brauner>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z2dp672+D9J6BSDfWsf1Jb/hgmWKqne5bNDgqenso8I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlzL6mcHFp19bQI7l7uz81l39avlFmaXBv44yXEUZWp
 4Qtr/RVd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkSQgjwwMPncU6F69xdzI3
 GNmvMHAQnX5XxCL2SOmr+lSB9duVaxgZZgY4znlUNNve0zXi9ewlRz4tyu0yfp3rcbdtj5DLDtb
 DfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-30 17:40 -0700, Paul E. McKenney wrote:
> The hrtimer_sleeper structure's ->task field is used as a flag to indicate
> that the associated hrtimer has expired.  This means that the hrtimer
> handler can be storing to this field while other code is loading from it
> to check for expiry.  Note that additional races appear for hrtimers that
> can be restarted, which could be argued to be a user error.  However, that
> is no reason to let the compiler introduce additional confusion, and to
> this end, the hrtimer_sleeper_task_get() was introduced, use of which also
> has the benefit of avoiding open-code access to hrtimer_sleeper innards.
> 
> KCSAN located this issue.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: <linux-aio@kvack.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> ---

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>


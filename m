Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388793246EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848320; cv=pass; b=FV78w28PAuYOevwoukaNYksaJDdvw8VIR6FmP0rbFVINzhsJVZolwgJyvEDa6UyRJlsFmgd2s0IuT9aPEO3H0aKDucVJP4oqEia+jsQYpQlbba7M/YkE0/MYUhXGBhJCA4veb8HzHxQDxQPHaV6LfLTBt01i1s+bQ6mEpeBmz/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848320; c=relaxed/simple;
	bh=GutvYltsxYYZRaOn67+yNsu7DUxLCxH3hhGl+I27cCg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XPvQwDEl82xBfUjbYl4vGGMtM57TvlnblXxchFkxBPorYvSB12P1pafzhbaFfUhxdAryklAWRJLLSchCk93mEtGPSBPMV3JCMSwJ0VRK4pUjtZgrUWq/+/YAihiWOa4n3IYbqMCZXgP7bbtOZdYQk2xklEbfs/WxXHf/y1NmgD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mutFZNyr; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mutFZNyr"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba699316b42so555572166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 01:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776848317; cv=none;
        d=google.com; s=arc-20240605;
        b=ZgVvYS6cdL/WU9BVz1rhjQ3/lruY0c/Lx7reY5nMvLYpENeUnSkLPgaMghVLoyQR+H
         ZeMzzM5r1e/Fnr4lQ8+3GV3xBbW4SOlHBgkeDW/V8rbz/uv2xMzsVp/S0nW1sxMAY775
         /aiwhYsZbXOCzSF8YYWDfW8zTyjTEa1it1N+mEhZOfZUN9E5ySm8IA7/axcmC0dkTXcI
         HoWX4nI4CNchIjaqq4CFRDzlHZJ9tRLn6qdsZNoVALU59EiOHXDxXUq+IinE0N54Rsyw
         vVJ164g82zc5yrFzws9oij58tjVqLzhav5+8tnuBzKXhbJCwdeZmZt5Fa0L7fm/lih14
         QuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GutvYltsxYYZRaOn67+yNsu7DUxLCxH3hhGl+I27cCg=;
        fh=K9x524UIiRk5R5AoZq5CXtTX+dc5QwH+ZGr4IhcRVs0=;
        b=PENISxIl7CRO/OLpS2mFnIjEJ/o92D0fEwMNtwkVWOrnh/6WmEypFrdYS7SpPsFRUP
         1qmiENG9e/bSMqyYO2NroEV2NS+D6BQ/Ojr3ypoXu0g1IOKCgIobtvUcwF25h8lPYZzt
         VxK5kBPx3adSobW+JoEpFlHc6+JPsBIkVx5C79x28E5cE4hUZPovSLcNc+xe9oJOxNiq
         EzeMqXxJ5ANx4pen5ZY8QMAt7nxbPeF+G6x6Rp9QyWBhVUug2GjCAp80rGnbQfNecH7W
         Sq/OWnBxExuNQD3jyM4qw/mOTiq3JVqXOQgZX/iOCLBbpDUBo5DYvj6SUCaUK3Kdu9En
         fnOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776848317; x=1777453117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GutvYltsxYYZRaOn67+yNsu7DUxLCxH3hhGl+I27cCg=;
        b=mutFZNyrFVv2noqtPTh0eNz8gQIZhxw+OhT0apsWpOm55eVSbyCJsKDQPhVFMf9blm
         ly/pd+JD4OyX9Y55daCpYID4WPg5WNBbUBjwe7pccS9LxOHQvL3iN9jX2ZA6+pLUWg7T
         UPkFEucElQLl6kojEq48lJnfZ8rJiJOLXWHHo51BA98nOJheC09edtHGz9rvfTqPNTwJ
         IILV0IMpa/56qF5ZaR+qU+89dBqUtQbKlgxaxrxvbKX+tRuEiDHIqRW9f3RFbUlX6INB
         NCjtRttnY0o7q1vm9663FrusT0gt6Neo2RVY0Dx7ur4WWrn2WavXEUz/tcqvUCWgYU5X
         Vn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848317; x=1777453117;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GutvYltsxYYZRaOn67+yNsu7DUxLCxH3hhGl+I27cCg=;
        b=sI0BYhPd/JlWSlyqnFfa9xYCJe8Sro5E0pyI2V6A1dwNCcVvfqbvIkq8zJdOxveSaT
         ur9I8Lc4uIdP4o3HYeA2GEZgyOJyAAZTj4eLZPdqFkVwWw760uk4zIKHMpe8QcKC1ea4
         QXYHhKnXXUVOOSWF37WTg+RUNMBNdMVLnSMzsg6hDTU/93oz404ivcky87BXC+soH3vb
         gh18aQ7rl1zPxOv9+IBaQGelf/VuecQlHC0/+h8d6iCkXpgjHsp8xkS1ZBGCzxYqB7H/
         RuNcNWLZdmSWM48XXtHg2OLLxBLkQi4NbiRdwH9qDk7Mts69hHclekIhb5zCmUL/0/Mt
         FGQQ==
X-Gm-Message-State: AOJu0YyXYpPG3ACkDfFmR8RX+JC8G0rGA+duz+rQBRK/o83EJoarxOQd
	oHaOEIXdGWSUPFoIsXrnXC4l5Rgxp5CMsBS//BnRJ4PMiL3hzJ268kPIl38/VowxoJwryVKGGm3
	/48N9zUJmDCtX9di5MA/qz1Cd/or/x+jG+GFF2Xk=
X-Gm-Gg: AeBDieuqTVpA5dUVrJMKJl8iObszsvNwnFtCAHyzAJY5M6x23d15IerURnIV1wopMFU
	hcK3UxtPicjXYfEJ5mx7xjF/3tUWzZckhBW09tSpCUEcDXqYQWZzRwi0Bl7Je+dVpGn5qFCOqPS
	/Fn4D10n67KMu/rBNDBi08WL7lg9Ek1rpbvCkUZ4IiZHKpWS32trfgCjTfJs93n2krB627b/dqB
	ccHjJ6lWzkPUaxcoqM5GauCxlKkGebEQvZk6z3mhsXDK1TW5HOirwtPnjNdbT9lkfdFsLA95Div
	2IfywFZl/Ns9cDCE125XJuZjYJdhRrdRScgmEZaoAZtPe1T+4qgZ
X-Received: by 2002:a17:907:6d0a:b0:ba4:a7a3:d03f with SMTP id
 a640c23a62f3a-ba4a7a3d86cmr1035584466b.27.1776848316967; Wed, 22 Apr 2026
 01:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Apr 2026 10:58:25 +0200
X-Gm-Features: AQROBzDarWzthyM27N8zDtaxRNMeUx6kQQoysPRclCDNeiPxu1ycUQL82SzW3C0
Message-ID: <CAOQ4uxgcYCOE4uWE1tAaVUPLNqmbp88_0MvM=gqiDtH=jBiW_A@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Filesystem breakout sessions
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

This is not a topic per se, more of a meta topic.

We did not get a huge amount of FS TOPIC proposals this year,
so we still have room in the agenda for more topics.

From my own personal experience, I am aware that people can refrain
from posting TOPIC proposals for half baked ideas or for topics that they
feel are too specific for the wider FS crowd and that is understandable.

As in previous years, FS track will be located in the large ballroom
(Emerald) which is also going to host the cross track and plenary sessions.

FS track has a stretch of time slots on Tuesday where we will be
relocated to the MM track's smaller room (Venice) to make room
for MM-IO and MM-BPF sessions.

In this setting, I would like to open the stage for people to talk
about whichever topic they like -
An idea they have been toying with,
An item on their TODO lists they never get to
A WIP branch that is bit-rotting on their work station.
We could of course use this time for FS specific BoFs and
Ask Me Anything sessions with fs/subsystems maintainers.

There will be no video recording of those sessions and we can ask
for LWN opt-out for any topic discussed therein.

IOW, bring the Hallway session into the room, so that other people
can participate and we can use the hallway time for gossip and
stuffing our faces.

No need to reply with specific topics now unless you want to.
Just keep this in mind and think of things that you may want to
bring up during these breakout sessions.

Thanks,
Amir.
